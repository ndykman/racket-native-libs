#include <windows.h>
#include <shlwapi.h>

#include <stdio.h>
#include <string.h>

#define MAX_DLLS 256

char foundDllFiles[MAX_PATH][MAX_DLLS];
BOOL visited[MAX_DLLS];

int dllQueue_last = 0;
char* dllQueue[MAX_DLLS];

int add_dll_to_queue(const char* dll_file)
{
    if (dllQueue_last >= MAX_DLLS)
        return -1;

    dllQueue[dllQueue_last] = _strdup(dll_file);
    dllQueue_last++;
    dllQueue[dllQueue_last] = NULL;
    return 0;
}

int file_index_dll_list(LPCSTR dllFile)
{
    for (int i = 0; i<MAX_DLLS; i++) {
        if (foundDllFiles[i] == NULL || strlen(foundDllFiles[i]) == 0) {
            return -1;
        }
        if (strcmp(dllFile, foundDllFiles[i]) == 0) {
            return i;
        }
    }

    return -1;
}

DWORD load_dll_list(LPSTR directory)
{
    char searchPath[MAX_PATH];
    strncpy_s(searchPath, MAX_PATH, directory, MAX_PATH);
    strncat_s(searchPath, MAX_PATH, "*.dll", MAX_PATH);

    WIN32_FIND_DATA findFileData;
    HANDLE hFind = FindFirstFile(searchPath, &findFileData);

    if (hFind == INVALID_HANDLE_VALUE) {
        printf("No dlls found");
    }

    int index = 0;
    do {
        strncpy_s(foundDllFiles[index], MAX_PATH, findFileData.cFileName, MAX_PATH);        
        index++;
    } while (FindNextFile(hFind, &findFileData));

    return 0;
}

DWORD get_parent_path(LPCSTR filePath, LPSTR directory) 
{
    char *filePart = NULL;

    DWORD length = GetFullPathNameA(filePath, MAX_PATH, directory, &filePart);
    if (length == 0 || length > MAX_PATH) {
        printf("Error: Unable to get full path. Code: %lu\n", GetLastError());
        return 1;
    }

    if (filePart != NULL) {
        // Terminate the string before the file name to get the parent directory
        *filePart = '\0';
    }

    return 0;
}

/* This function created by Copilot, reviewed. */

DWORD rva_to_offset(DWORD rva, IMAGE_NT_HEADERS *nt)
{
    IMAGE_SECTION_HEADER *sec =
        (IMAGE_SECTION_HEADER*)((BYTE*)&nt->OptionalHeader +
                                nt->FileHeader.SizeOfOptionalHeader);

    for (int i = 0; i < nt->FileHeader.NumberOfSections; i++) {
        DWORD va = sec[i].VirtualAddress;
        DWORD size = sec[i].SizeOfRawData;

        if (rva >= va && rva < va + size) {
            return sec[i].PointerToRawData + (rva - va);
        }
    }
    return 0;
}

/* This function created by Copilot, reviewed. */

void visit_dlls(const char* parent, const char *path)
{    
    // Open the file for memory mapping. This is used to make it
    // easier to seek to various parts of the file.
    HANDLE hFile = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ,
                               NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (hFile == INVALID_HANDLE_VALUE) {
        fprintf(stderr, "Cannot open %s\n", path);
        return;
    }

    HANDLE hMap = CreateFileMappingA(hFile, NULL, PAGE_READONLY, 0, 0, NULL);
    if (!hMap) {
        CloseHandle(hFile);
        return;
    }

    BYTE *base = (BYTE*)MapViewOfFile(hMap, FILE_MAP_READ, 0, 0, 0);
    if (!base) {
        CloseHandle(hMap);
        CloseHandle(hFile);
        return;
    }

    // Here's all the needed bits to list the dependent dlls. 
    IMAGE_DOS_HEADER *dos = (IMAGE_DOS_HEADER*)base;
    IMAGE_NT_HEADERS *nt = (IMAGE_NT_HEADERS*)(base + dos->e_lfanew);

    IMAGE_DATA_DIRECTORY *dir =
        &nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT];

    if (dir->VirtualAddress == 0)
        goto cleanup;

    DWORD imp_offset = rva_to_offset(dir->VirtualAddress, nt);
    if (!imp_offset)
        goto cleanup;

    IMAGE_IMPORT_DESCRIPTOR *imp =
        (IMAGE_IMPORT_DESCRIPTOR*)(base + imp_offset);

    while (imp->Name) {
        DWORD name_offset = rva_to_offset(imp->Name, nt);
        if (!name_offset)
            break;

        const char *dllName = (const char*)(base + name_offset);

        // If this dll was found in the directory and not already visited
        // then push this dll on the stack and recurse. 
        
        char fullDllPath[MAX_PATH];
        PathCombine(fullDllPath, parent, dllName);
        
        int index = file_index_dll_list(dllName);

        if (index != -1 && !visited[index]) {
            visit_dlls(parent, fullDllPath);
            add_dll_to_queue(dllName);
            visited[index] = TRUE;
        } 

        imp++;
    }

cleanup:
    UnmapViewOfFile(base);
    CloseHandle(hMap);
    CloseHandle(hFile);
}

int main(int argc, char **argv)
{
    if (argc != 2 || 
        strcmp(argv[1],"-h") == 0 || 
        strcmp(argv[1],"--help") == 0) 
    {
        printf("usage: %s [pathToDllFile]", argv[0]);
        return 1;
    }
    char resolved[MAX_PATH];

    if (!SearchPathA(NULL, argv[1], NULL, MAX_PATH, resolved, NULL)) {
        fprintf(stderr, "Cannot find file: %s\n", argv[1]);
        return 1;
    }

    char dllPath[MAX_PATH];
    
    get_parent_path(resolved,dllPath);
    load_dll_list(dllPath);
    visit_dlls(dllPath,resolved);

    int index = 0;

    while (dllQueue[index] != NULL) {
        printf("(ffi-lib \"%s\")\n", dllQueue[index]);
        index++;
    }

    // Finally print the library that was passed to the executable. 
    printf("(ffi-lib \"%s\")\n",  PathFindFileName(resolved));
    return 0;
}
