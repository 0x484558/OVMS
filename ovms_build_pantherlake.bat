@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Keep every local build action at four jobs on this machine.
set "OVMS_ACTION_PATH=C:\opt;C:\opt\Python312;C:\opt\Python312\Scripts;C:\opt\msys64\usr\bin;C:\Users\User\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd;C:\Windows\system32;C:\Windows;C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64;C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"

call windows_setupvars.bat
if errorlevel 1 exit /b %errorlevel%

bazel --output_user_root=C:\opt build ^
  --config=win_mp_on_py_off ^
  --config=avx2_win ^
  --copt=/D__m128i_u=__m128i ^
  --host_copt=/D__m128i_u=__m128i ^
  --action_env OpenVINO_DIR=C:/opt/openvino/runtime/cmake ^
  --action_env "PATH=!OVMS_ACTION_PATH!" ^
  --action_env CMAKE_BUILD_PARALLEL_LEVEL=1 ^
  --jobs=4 ^
  --local_cpu_resources=4 ^
  --verbose_failures ^
  //src:ovms

exit /b %errorlevel%
