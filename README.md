# Racket External Library Build Project


This a project that uses a empty [CMake](https://cmake.org/) project alongside the [vcpkg](https://vcpkg.io/en/) project to download and build the various external shared libraries needed by [Racket](https://www.racket-lang.org/) and various Racket packages. The projects are built using the MSVC compiler and build tools. 

## Prerequisites

OS: Windows 11/Windows Server 2025 (or later) running on x64. Earlier versions may work, but are not tested nor supported. If you are using ARM64, [this section](#windows-on-arm64) has additional information on how to change the project to work on ```arm64``` machines. 

```winget``` is used to install the needed tooling. It is suggested that ```cmake```, ```vcpkg``` and the MSVC build tools be installed in a top level directory (in this example, ```C:\tools```). If you are having problems with ```winget``` consult the [official documentation](https://learn.microsoft.com/en-us/windows/package-manager/winget/) for guidance. 

The following is a set of instructions to help set up the environment from a new Windows 11 installation. If you have the needed tools or an established Windows development environment, please feel free to adapt these instructions to best work for you. 

### Step 1:

Use ```winget``` to install Powershell Core, Windows Terminal, Git, CMake and the Visual Studio Build Tools. Open a Command Prompt (```cmd.exe```) and execute the following:

```cmd
winget source update
winget update
```

Go ahead and update Windows Terminal and the App Installer if needed (if they are listed after running the last command above). If Windows Terminal isn't installed, then execute the following:

```cmd
winget install Microsoft.WindowsTerminal
```

to install it. This makes it easier to open the needed PowerShell terminal windows later Then you can run the following in a ```cmd``` prompt to get the latest PowerShell, Git and CMake. Again, this installs the development tools in ```C:\tools```. Accept any prompts to install the tools if they appear.  

```cmd
winget install Microsoft.Powershell 
winget install Git.Git -l C:\tools\git
winget install Kitware.CMake -l C:\tools\cmake
winget install Microsoft.VisualStudio.BuildTools --override  "--passive --path install=C:\tools\msvc --path cache=C:\tools\msvc_cache --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.Windows11SDK.22621 --add Microsoft.Component.VC.Runtime.UCRTSDK"
```

### Step 2:

Close the existing cmd prompt and open a Powershell session via Windows Terminal. This is to pick up new path entries. Note, you want a ```Powershell``` session, not a ```Microsoft Powershell``` session which opens a older (and soon to be removed from Windows) version of Powershell. One can setup Terminal to open a ```Powershell``` session by default by changing the settings.  

Go ahead and install ```vcpkg```. ```vcpkg``` is actually a git repository, so it is installed via git.  

```powershell
cd C:\tools
git clone https://github.com/microsoft/vcpkg.git
```

This will clone the needed repository. 

### Step 3:

You need to integrate ```vcpkg``` into the shell. Run

```powershell
cd C:\ctools\vcpkg; 
.\bootstrap-vcpkg.bat
``` 

Your environment should now be setup. 

### Optional Step 4:

The compilation process can be negatively impacted by Windows Security Antivirus scanning. To address this, run ```PowerShell``` as an admin and do the following:

```
Add-MpPreference -ExclusionPath "C:\tools\vcpkg\*"
```

This excludes vcpkg from being scanned. Since this where all the build activity happens, this can be helpful. 

Using the Dev Drive Windows feature can also be really useful. See [this](https://learn.microsoft.com/en-us/windows/dev-drive/) for information on how to set up a Dev Drive. For power users, it is possible to remove the anti-virus filter on all Dev Drives, which for some scenarios can have a noticeably positive impact on performance, but has increased security risks.  

## Checking Setup

Run Windows Terminal and verify there is an option to open ```Developer PowerShell for Visual Studio 18```. ```Visual Studio 18``` is the latest version; Microsoft has recently moved away from year based versioning for the build tools.

From now, on run the commands in a ```Developer PowerShell for Visual Studio 18``` terminal session. This ensures that the needed tools are in the ```path``` and can be found by ```vcpkg```

### Environment Variable Setup
To use ```cmake``` and ```vcpkg```, the appropriate environment variables need to be set:

```powershell
$env:VCPKG_ROOT = "C:\tools\vcpkg"
$env:PATH = "$env:VCPKG_ROOT;C:\tools\cmake\bin;$env:PATH"
```
 
If there are any problems building the project, make sure that the environment is setup appropriately. 

We have finished installing the needed tools and we can move to building the libraries. 


## Clone The Project

Again, it is highly recommended that a top level directory is used for the sources for this project. This is largely due to some long paths when GTK is built. We will use ```C:\rl``` as an example.

Go ahead and run the following:

```powershell
mkdir C:\rl
cd C:\rl
git clone https://github.com/ndykman/racket-native-libs.git
```

then change to the project source directory: 

```powershell
cd C:\rl\racket-native-libs
```

## Copying Community Triplets

There are some ```vcpkg``` triplets that this project uses that don't come with the standard distribution. 

Run the following to copy them. 

```powershell
Copy-Item .\triplets\*.cmake "$ENV:VCPKG_ROOT\triplets\community"
```

## Build The Libraries
You can now run 
```
.\Build-Racket-Libs.ps1 -Arch [arch]
``` 

where ```[arch]``` can be one of ```x64, x86, arm64```. If this fails, make sure CMake and VCPkg is in your path.  

This will take some time as it is building a fairly large set of shared libraries for both the build and host systems. 

Again, be patient, this can run for a noticeable amount of time; two hours can be expected. Take the opportunity to get away from your desk, get a nice beverage, look outside the window, maybe even take a walk.  

If all is well and done, you should see a message like the following: 

```
All requested installations completed successfully in: 1.1 s
-- Running vcpkg install - done
```

You may see an error about ninja not being found, you can ignore this. Repeat this step for each architecture.

### Additional Troubleshooting

On occasion, the build tools seem to get stuck and files are locked. If you get a build error, just try rerunning the ```Build-Racket-Libs.ps1``` script again. This seems to be a weird interaction with the Visual Studio Build Tools and CMake. 

## Preparing the Shared Libraries

You should now be able to copy the libraries into a form suited for the packages by running the following:

```Copy-Racket-Libs.ps1```

this will create a ```dist``` directory with three sub-directories for each architecture. In each of those directory, there will be a  ```base```, ```draw```, ```gui```, ```poppler``` and ```etc``` directory with a directory for each architecture. This should have all the needed libraries for the major packages in Racket.  

# Acknowledgements

Thanks to the Racket community for being supportive of these efforts and ensuring that Racket works on all major operating systems. This is often tiring work that isn't given enough recognition. 

# Motivation and Additional Information

```vcpkg``` was chosen as it has a large number of libraries that it supports, including a large set of patches to get them to build correctly. Managing this information manually would be overwhelming. 

There is community support in ```vcpkg``` for ```MinGW``` based cross-compilation on Linux. However the toolchain is just not mature enough at this point to support Windows libraries on all the architectures. ```arm64``` is especially problematic in some cases. Now, if the cross-compilation tools reach the point that they are useful, they would be preferred by the racket project as racket itself is built with cross-compiler tooling on Linux.  Cross-compilation for MacOS is currently not supported. 

Now, ```vcpkg``` can be used on Linux, MacOS and Windows for native builds and those are officially supported. 

Finally, it is vital to note that a external library used by Racket does *not* need to be a vcpkg. 

## Unsupported ProjectConfigurations

For unsupported configurations, a deeper knowledge of ```cmake``` is really useful, especially how the preset ```json``` files work and how host and target triplets interact. Given this, one can use this project as a launching point for building libraries on different hosts and targers. 

```vcpkg``` does support MacOS, Windows and Linux, it shpuld possible to use these systems to create dynamic libraries. This may not be the best case for Linux and MacOS versus using package manager to install dependencies. Like Windows, one needs to install the appropriate tooling, including a host C/C++ tooling and cross compilers if needed. 

### Linux

This is unsupported, but seems to work. 

One needs to install the gcc/g++ toolchain (preferred) or clang. Also, cmake (version 4.x), git and the ninja build tool need to be installed. Then, you can clone the vcpkg repository (say, in ```/opt/vcpkg```) and follow the instructions [here](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started?pivots=shell-bash) to setup vcpkg in the Linux environment.  

One can checkout this repository and run ```cmake --preset=x64-linux-release -B build-x64-linux``` and see what happens.

You may see warnings like the following:

```
You will need to install Xorg dependencies to use feature x11:

  sudo apt install libx11-dev libxft-dev libxext-dev
```

This is an example warning about system packages these libraries may need to be fully usable. These are mainly about ```x11``` or ```wayland``` shared libraries which are intended to be installed on a system-wide basis. 

### MacOS

This is unsupported and never been tried, as the author has no current access to a MacOS environment.  

One needs XCode installed as well as cmake, git and ninja (available via homebrew or ports). Use the same instructions to setup vcpkg as noted for Linux. 

Then checkout this repository and run ```cmake --preset=arm64-osx-release -B build-arm64-osx```

## Windows on ARM64

This may work (currently untested), but a modification to the ```CMakePresets.json``` needs to be made. The following line in ```cacheVariables``` of the ```windows-base``` preset needs to be changed to match the following.  

```"VCPKG_HOST_TRIPLET": "arm64-windows"```

This reflects that the host is an ```arm64``` machine. The rest can proceed as in the main part of the documentation. 

# Endnote 

This project currently has one author and contributor, who is disabled and has limited resources in terms of time and money. Your consideration is appreciated when requesting changes or reporting bugs.