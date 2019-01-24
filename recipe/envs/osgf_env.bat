@echo off
REM NOTE: assumes this file is in CONDA_ROOT\LIBRARY_PREFIX\bin

REM Make parent of this script location our current directory,
REM converting UNC path to drive letter if needed
if "%LIBRARY_PREFIX%" == "" (
  pushd "%~dp0"
    cd ..
    set "LIBRARY_PREFIX=%CD%"
  popd
)
if "%LIBRARY_PREFIX_SHORT%" == "" (
  REM Set LIBRARY_PREFIX to short path version
  for %%i in ("%LIBRARY_PREFIX%") do set LIBRARY_PREFIX_SHORT=%%~fsi
)

if "%LIBRARY_PREFIX_POSIX%" == "" set LIBRARY_PREFIX_POSIX=%LIBRARY_PREFIX:\=/%
if "%LIBRARY_PREFIX_SHORT_POSIX%" == "" set LIBRARY_PREFIX_SHORT_POSIX=%LIBRARY_PREFIX_SHORT:\=/%

if "%CONDA_ROOT%" == "" (
  pushd "%~dp0"
    cd ..\..
    set "CONDA_ROOT=%CD%"
  popd
)
if "%CONDA_ROOT_SHORT%" == "" (
  REM Set CONDA_ROOT to short path version
  for %%i in ("%CONDA_ROOT%") do set CONDA_ROOT_SHORT=%%~fsi
)

if "%CONDA_ROOT_POSIX%" == "" set CONDA_ROOT_POSIX=%CONDA_ROOT:\=/%
if "%CONDA_ROOT_SHORT_POSIX%" == "" set CONDA_ROOT_SHORT_POSIX=%CONDA_ROOT_SHORT:\=/%

if "%ACTIVATED_OSGF_ENV%" == "1" goto :EOF

REM Some convenience vars
set PF=%PROGRAMFILES%
set PF86=%PROGRAMFILES(x86)%
for %%i in ("%PROGRAMFILES%") do set PF_SHORT=%%~fsi
for %%i in ("%PROGRAMFILES(x86)%") do set PF86_SHORT=%%~fsi

REM Don't mess with any standard conda env vars, if called during conda-build; skip to activation
REM Reload _h_env activate scripts (clobbered by conda-build's _build_env final activation)
if not "%CONDA_BUILD%" == "" goto reactivate

pushd "%~dp0"

  REM Standard Win Library locations
  if "%LIBRARY_BIN%" == "" set "LIBRARY_BIN=%LIBRARY_PREFIX%\bin"
  if "%LIBRARY_INC%" == "" set "LIBRARY_INC=%LIBRARY_PREFIX%\include"
  if "%LIBRARY_LIB%" == "" set "LIBRARY_LIB=%LIBRARY_PREFIX%\lib"
  if "%SCRIPTS%" == "" set "SCRIPTS=%CONDA_ROOT%\Scripts"

  REM Load the prefix's environment
  if exist "%CONDA_ROOT_SHORT%\Scripts\activate.bat" (

    REM Load conda env via prefix
    "%CONDA_ROOT_SHORT%\Scripts\activate.bat" "%CONDA_ROOT%"
    goto end

  ) else (

    REM conda not available (e.g. bare pkgs installed from constructor, without conda)
    REM Set up fake conda env...

    if "%CONDA_PYTHON_EXE%" == "" set "CONDA_PYTHON_EXE=%CONDA_ROOT_SHORT%\python.exe"
    set "PYTHONNOUSERSITE=1"
    if "%PYTHONIOENCODING%" == "" set "PYTHONIOENCODING=1252"

    REM These may not make sense in an no-root-env install prefix
    REM set "SYS_PREFIX=%CONDA_ROOT_SHORT%"
    REM set "SYS_PYTHON=%CONDA_ROOT_SHORT%\python.exe"

    if "%STDLIB_DIR%" == "" set "STDLIB_DIR=%CONDA_ROOT_SHORT%\Lib"
    if "%SP_DIR%" == "" set "SP_DIR=%CONDA_ROOT_SHORT%\Lib\site-packages"

    path "%CONDA_ROOT%;%LIBRARY_PREFIX%\mingw-w64\bin;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_PREFIX%\bin;%CONDA_ROOT%\Scripts;%PATH%"

  )

popd

:reactivate

REM Load activate scripts
if exist "%LIBRARY_PREFIX%\bin\reactivate_env.bat" call "%LIBRARY_PREFIX%\bin\reactivate_env.bat"

:end

set ACTIVATED_OSGF_ENV=1
