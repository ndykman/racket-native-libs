param(
    [Parameter(Mandatory)]
    [ValidateSet("x64","x86","arm64")]
    [string]$Arch
)

switch ($Arch) {
    "x64" { cmake.exe --preset=x64-release -B build-x64}
    "x86" { cmake.exe --preset=x86-release -B build-x86}
    "arm64" {cmake.exe --preset=arm64-release -B build-arm64} 
}
