echo off

rem Copyright 2023-2024 DreamWorks Animation LLC
rem SPDX-License-Identifier: Apache-2.0

rem setup environment variables to use release

set cwd=%CD%
cd %~dp0%..
set omr_root=%CD%
cd %cwd%
set cwd=

rem Walk up to find the top-level install dir where the dependencies are installed
rem set install_root=%omr_root%
rem while [ "$(basename ${install_root})" != "installs" ]
rem do
rem    install_root=$(dirname install_root})
rem done

echo "Setting up release in %omr_root%"

rem NB required for Arras to function (it needs to find execComp)
set PATH=%omr_root%\bin;%PATH%

rem need python modules for the USD interface and for the RATS tests
set PYTHONPATH=%omr_root%\python\lib\python3.10;%PYTHONPATH%


rem tell moonray where to find dsos
set RDL2_DSO_PATH=%omr_root%\rdl2dso

rem tell moonray where to find shaders file for XPU mode.
rem it will look for ${REZ_MOONRAY_ROOT}/shaders/GPUShaders.ptx
set REZ_MOONRAY_ROOT=%omr_root%

rem tell Arras where to find session files
set ARRAS_SESSION_PATH=%omr_root%\sessions

rem tell Hydra Ndr plugins where to find shader descriptions
set MOONRAY_CLASS_PATH=%omr_root%\shader_json

rem add Hydra plugins to path
set PXR_PLUGINPATH_NAME=%omr_root%\plugin\pxr;%PXR_PLUGINPATH_NAME%
set PXR_PLUGIN_PATH=%omr_root%\plugin\pxr;%PXR_PLUGIN_PATH% # for legacy DWA USD builds

rem create shader descriptions if they don't exist
if not exist %omr_root%\shader_json (
    echo "Building shader descriptions..."
    %omr_root%\bin\rdl2_json_exporter --out %omr_root%\shader_json\ --sparse
    echo "...done"
)
