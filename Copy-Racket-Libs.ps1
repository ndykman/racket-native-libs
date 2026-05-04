if (-not (Test-Path -Path ".\dist")) {
    New-Item -Path "." -Name "dist" -ItemType Directory
}

if (-not (Test-Path -Path ".\dist\x64-windows" )) {
    New-Item -Path ".\dist" -Name "x64-windows" -ItemType Directory
}

if (-not (Test-Path -Path ".\dist\x86-windows" )) {
    New-Item -Path ".\dist" -Name "x86-windows" -ItemType Directory
}

if (-not (Test-Path -Path ".\dist\arm64-windows" )) {
    New-Item -Path ".\dist" -Name "arm64-windows" -ItemType Directory
}

$src_lib_path = ".\build-x64\vcpkg_installed\x64-windows\bin"
$dist_path = ".\dist\x64-windows\base"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\legacy.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libcrypto-3-x64.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libssl-3-x64.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sqlite3.dll" -Destination "$dist_path"

$dist_path = ".\dist\x64-windows\draw"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\bz2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-gobject-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-script-interpreter-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\epoxy-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fontconfig-1.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fribidi-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk_pixbuf-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gio-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\glib-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmodule-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gobject-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz-subset.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\intl-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libexpat.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\liblzma.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pango-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangocairo-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangoft2-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangowin32-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pcre2-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pixman-1-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\x64-windows\gui"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\gtk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\atk-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gailutil-3-vs17.dll" -Destination "$dist_path"

$dist_path = ".\dist\x64-windows\math"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\mpfr-6.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmp-10.dll" -Destination "$dist_path"

$dist_path = ".\dist\x64-windows\poppler"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\poppler.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\openjp2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\x64-windows\etc"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\argon2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\git2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sass-1.dll" -Destination "$dist_path"

# Yea, this is copy paste just for a few different library names, but simple 
# beats clever here. 

$src_lib_path = ".\build-x86\vcpkg_installed\x86-windows\bin"
$dist_path = ".\dist\x86-windows\base"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\legacy.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libcrypto-3.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libssl-3.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sqlite3.dll" -Destination "$dist_path"

$dist_path = ".\dist\x86-windows\draw"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\bz2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-gobject-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-script-interpreter-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\epoxy-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fontconfig-1.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fribidi-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk_pixbuf-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gio-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\glib-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmodule-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gobject-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz-subset.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\intl-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libexpat.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\liblzma.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pango-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangocairo-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangoft2-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangowin32-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pcre2-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pixman-1-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\x86-windows\gui"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\gtk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\atk-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gailutil-3-vs17.dll" -Destination "$dist_path"

$dist_path = ".\dist\x86-windows\math"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\mpfr-6.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmp-10.dll" -Destination "$dist_path"

$dist_path = ".\dist\x86-windows\poppler"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\poppler.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\openjp2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\x86-windows\etc"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\argon2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\git2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sass-1.dll" -Destination "$dist_path"

# ARM64 libraries

$src_lib_path = ".\build-arm64\vcpkg_installed\arm64-windows\bin"
$dist_path = ".\dist\arm64-windows\base"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\legacy.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libcrypto-3-arm64.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libssl-3-arm64.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path" 
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sqlite3.dll" -Destination "$dist_path"

$dist_path = ".\dist\arm64-windows\draw"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\bz2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-gobject-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\cairo-script-interpreter-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\epoxy-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\ffi-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fontconfig-1.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\fribidi-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk_pixbuf-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gdk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gio-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\glib-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmodule-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gobject-2.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\harfbuzz-subset.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\iconv-2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\intl-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libexpat.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\liblzma.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pango-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangocairo-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangoft2-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pangowin32-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pcre2-8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\pixman-1-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\arm64-windows\gui"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}
Copy-Item -Path "$src_lib_path\gtk-3-vs17.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\atk-1.0-0.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gailutil-3-vs17.dll" -Destination "$dist_path"

$dist_path = ".\dist\arm64-windows\math"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\mpfr-6.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\gmp-10.dll" -Destination "$dist_path"

$dist_path = ".\dist\arm64-windows\poppler"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\brotlicommon.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlidec.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\brotlienc.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\freetype.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\libpng16.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\jpeg8.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\poppler.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\openjp2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\tiff.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\zlib1.dll" -Destination "$dist_path"

$dist_path = ".\dist\arm64-windows\etc"

if (-not (Test-Path -Path "$dist_path")) {
    New-Item -Path "$dist_path" -ItemType Directory
}
else {
    Remove-Item -Path "$dist_path\*.dll"
}

Copy-Item -Path "$src_lib_path\argon2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\git2.dll" -Destination "$dist_path"
Copy-Item -Path "$src_lib_path\sass-1.dll" -Destination "$dist_path"