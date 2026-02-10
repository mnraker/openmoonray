# Building OpenMoonRay on Windows (vcpkg + Ninja)

This repository provides an **opt-in Windows build configuration** using
**vcpkg (manifest mode)** and **Ninja**.

This workflow is additive and does not modify or replace any existing
build configurations.

------------------------------------------------------------------------

## Overview

The Windows build uses:

-   **CMake Presets**
-   **Ninja generator**
-   **vcpkg manifest mode** (`vcpkg.json` in the repository root)
-   **ISPC** for SIMD kernel compilation

Dependencies are resolved automatically via vcpkg.

------------------------------------------------------------------------

## Prerequisites

Install the following software before building.

### 1. Visual Studio 2022

-   Edition: Community or higher
-   Required workload:
    -   **Desktop development with C++**

Download:\
https://visualstudio.microsoft.com/downloads/

------------------------------------------------------------------------

### 2. CMake (3.23.1 or newer)

Minimum version matches the project requirement.

Download:\
https://cmake.org/download/

Verify installation:

``` powershell
cmake --version
```

------------------------------------------------------------------------

### 3. Ninja

Ninja must be available in your `PATH`.

Download:\
https://github.com/ninja-build/ninja/releases

Verify:

``` powershell
ninja --version
```

------------------------------------------------------------------------

### 4. Git (with submodules)

Git is required to clone the repository and its submodules.

Download:\
https://git-scm.com/download/win

Clone the repository using:

``` powershell
git clone --recurse-submodules <repository-url>
```

------------------------------------------------------------------------

### 5. vcpkg

Clone and bootstrap vcpkg:

``` powershell
git clone https://github.com/microsoft/vcpkg.git
cd vcpkg
.\bootstrap-vcpkg.bat
```

Set the environment variable:

``` powershell
setx VCPKG_ROOT "C:\path\to\vcpkg"
```

Restart your shell after setting the variable.

Repository:\
https://github.com/microsoft/vcpkg

------------------------------------------------------------------------

### 6. ISPC (Intel SPMD Program Compiler)

Required for MoonRay SIMD kernel compilation.

-   Minimum recommended version: **1.26+**

Download:\
https://github.com/ispc/ispc/releases

After downloading:

Option A --- Add ISPC to `PATH`\
Option B --- Set environment variable:

``` powershell
setx ISPC_HOME "C:\path\to\ispc"
```

Verify:

``` powershell
ispc --version
```

------------------------------------------------------------------------

### 7. Python (3.10 or newer)

Python is required for some build utilities and bindings.

Download:\
https://www.python.org/downloads/

Verify:

``` powershell
python --version
```

------------------------------------------------------------------------

## Configure

From the repository root:

``` powershell
cmake --preset windows-vcpkg-local-release
```

This will:

-   Enable the vcpkg toolchain
-   Resolve dependencies defined in `vcpkg.json`
-   Generate Ninja build files

------------------------------------------------------------------------

## Build and Install

``` powershell
cmake --build --preset windows-vcpkg-local-release
```

Artifacts are installed to:

    _install/windows-vcpkg-local-release/

------------------------------------------------------------------------

## Notes

-   Dependencies are managed automatically via `vcpkg.json`.
-   No manual `vcpkg install` commands are required.
-   Ensure all prerequisites are installed before configuring.
