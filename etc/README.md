# Racket DLL Helper

Firstly, you will need to be in the same environment that builds the native libraries. In other words, you need access to the MSVC C/C++ compiler (`cl.exe`) and make (`nmake.exe`) tool. 

Run nmake in this directory. This should create the `racketdllhelper.exe` executable. 

Run `racketdllhelper.exe` and pass it a DLL file as the first argument. It will output a set of `(ffi-lib ...)` statements that are in the order needed to load the DLL file. 

Note, all the dependent libraries should be in the same directory as the lib passed to the tool. If not, the tool will ignore them as it assumes those are system dependencies and out of scope for the tool.
