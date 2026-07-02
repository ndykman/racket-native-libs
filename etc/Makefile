# Compiler and flags
CC = cl
CFLAGS = /nologo /W4 /Ox
LIBS = shlwapi.lib

# Target and source
TARGET = racketdllhelper.exe
SRC = main.c

# Default rule
all: $(TARGET)

$(TARGET): $(SRC)
    $(CC) $(CFLAGS) /Fe:$(TARGET) $(SRC) $(LIBS)

# Cleanup
clean:
    del /Q $(TARGET) *.obj *.pdb 2>NUL
