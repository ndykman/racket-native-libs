Racket External Library Build Project
====

This a project that uses a empty [CMake](https://cmake.org/) project alongside the [vcpkg](https://vcpkg.io/en/) project to download and build the various external shared libraries needed by [Racket](https://www.racket-lang.org/) and various Racket packages. The projects are built using the MSVC compiler and build tools. 

Prerequisites
----

OS: Windows 11/Windows Server 2025 (or later). Earlier versions may work, but are not tested nor supported. 

```winget``` is used to install the needed tooling. It is suggested that ```cmake```, ```vcpkg``` and the MSVC build tools be installed in a top level directory (in this example, C:\ctools). 

The following is a set of instructions to help set up the environment from scratch. If you have the needed tools, please feel free to adapt as necessary. 

Step 1:

Use ```winget``` to install Powershell Core, Windows Terminal, Git, CMake and the Microsoft Build Tools. Open the Command Prompt (```cmd.exe```) and execute the following:

```cmd
winget update
winget install Microsoft.Powershell Microsoft.WindowsTerminal
winget install Git.Git
winget install Kitware.CMake -l C:\ctools\cmake
winget install Microsoft.VisualStudio.BuildTools -l C:\ctools\msvc
```

Step 2:

```vcpkg``` is actually a git repository, so it is installed via git.  

```cmd
cd C:\ctools
git clone https://github.com/microsoft/vcpkg.git
```

This will clone the needed repository. 

Step 3:

You need to integrate ```vcpkg``` into the shell. Run

```cmd
cd C:\ctools\vcpkg; .\bootstrap-vcpkg.bat
``` 

Your environment should now be setup. 

To use ```cmake``` and ```vcpkg```, make sure the appropriate environment variables are set:

```powershell
$env:VCPKG_ROOT = "C:\ctools\vcpkg"
$env:PATH = "$env:VCPKG_ROOT;C:\ctools\cmake\bin;$env:PATH"
```

Cloning this project
---

Again, it is highly recommended that a top level directory is used for the sources for this project. This is largely due to some long paths when GTK is built. We will use C:\rl_src as an example.

```powershell
mkdir C:\rl_src 
cd C:\rl_src
git clone [TODO: add actual URL here]
```

Again, open a Developer PowerShell for VS 18 terminal window and change to the project source directory ```C:\rl_src```

You can now run 
```
.\Build-Racket-Libs.ps1 -Arch [arch]
``` 

where ```[arch]``` can be one of ```x64, x86, arm64```. If this fails, make sure CMake and VCPkg is in your path. 

This will take some time as it is building a fairly large set of shared libraries for both the build and host systems. 

If all is well, you should see a message like the following: 

```
All requested installations completed successfully in: 1.1 s
-- Running vcpkg install - done
```

You may see an error about ninja not being found, you can ignore this. Repeat this step for each architecture.

### Troubleshooting

On occasion, the build tools seem to get stuck and files are locked. If you get a build error, just try rerunning the ```bBuild-Racket-Libs.ps1``` again. This seems to be a weird cmake and MSVC tooling bug.

Preparing the Shared Libraries
====

TODO: Finalize the appropriate layout with the Racket core team. 

You should now be able to copy the libraries into a form suited for the packages
by running 

```Copy-Racket-Libs.ps1```

this will create a ```dist``` directory with three sub-directories for each architecture. In each of those directory, there base, draw, gui, poppler and etc directory. 

NOTE: Need to add longdouble.dll and myssink.dll builds. 

Additional Information
===

vcpkg was chosen as it has a large number of libraries that it supports, including a large set of patches to get them to build correctly. Managing this information manually would be overwhelming. 

Now, it would be nice if these tools could used on Linux for cross-compilation. 
As of now, the libraries and the toolchain is just not mature enough for this. ARM64 is especially problematic currently. If future toolchain support improves, these tools can be used on Linux as vcpkg is supported on Windows, MacOS and Linux. 

With some future testing, it is possible this project can be used to build and track all the needed external shared libraries for Racket on Linux, MacOS and Windows.

It is vital to note that a external library used by Racket does *not* need to be a vcpkg. 

Acknowledgements
===

Thanks to the Racket community for being supportive of these efforts and ensuring that Racket works on all major operating systems. This is often tiring work that isn't given enough recognition. 