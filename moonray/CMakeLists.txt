# Copyright 2023-2025 DreamWorks Animation LLC
# SPDX-License-Identifier: Apache-2.0

# Optional component toggles (defaults keep current behavior)
option(OMR_BUILD_HYDRA           "Build Hydra plugin (requires USD/pxr)" ON)
option(OMR_BUILD_DENOISE         "Build denoiser (requires OpenImageDenoise)" ON)
option(OMR_BUILD_MOONRAY_ARRAS   "Build Arras distributed rendering support" ON)
option(OMR_BUILD_DCC_PLUGINS     "Build DCC plugins (e.g. Houdini)" ON)
option(OMR_BUILD_MOONSHINE_USD   "Build moonshine_usd (requires USD/pxr)" ON)
option(OMR_BUILD_DWA_EXT         "Build DWA extensions (if present)" ON)
option(OMR_BUILD_TOOLS           "Build optional tools (if present)" ON)

if(OMR_BUILD_HYDRA)
  add_subdirectory(hydra)
endif()

if(OMR_BUILD_DENOISE)
  add_subdirectory(mcrt_denoise)
endif()

add_subdirectory(moonray)

if(OMR_BUILD_MOONRAY_ARRAS)
  add_subdirectory(moonray_arras)
endif()

if(OMR_BUILD_DCC_PLUGINS)
  add_subdirectory(moonray_dcc_plugins)
endif()

add_subdirectory(moonshine)

if(OMR_BUILD_DWA_EXT AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/moonshine_dwa")
  add_subdirectory(moonshine_dwa)
endif()

if(OMR_BUILD_TOOLS AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/moonray_tools")
  add_subdirectory(moonray_tools)
endif()

if(OMR_BUILD_MOONSHINE_USD)
  add_subdirectory(moonshine_usd)
endif()

add_subdirectory(render_profile_viewer)
add_subdirectory(scene_rdl2)

if (${BUILD_QT_APPS})
  add_subdirectory(moonray_gui)
endif()
