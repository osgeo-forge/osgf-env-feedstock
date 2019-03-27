@echo off
REM NOTE: assumes this file is in CONDA_ROOT\LIBRARY_PREFIX\bin

REM Get parent of this script, converting UNC path to drive letter if needed
for %%a in (%~dp0\..) do set LIBRARY_PREFIX=%%~fa
if "%LIBRARY_PREFIX_SHORT%" == "" for %%i in ("%LIBRARY_PREFIX%") do set LIBRARY_PREFIX_SHORT=%%~fsi
if "%LIBRARY_PREFIX_POSIX%" == "" set LIBRARY_PREFIX_POSIX=%LIBRARY_PREFIX:\=/%
if "%LIBRARY_PREFIX_SHORT_POSIX%" == "" set LIBRARY_PREFIX_SHORT_POSIX=%LIBRARY_PREFIX_SHORT:\=/%

REM Get grandparent of this script, converting UNC path to drive letter if needed
for %%a in ("%LIBRARY_PREFIX%\..") do set CONDA_ROOT=%%~fa
if "%CONDA_ROOT_SHORT%" == "" for %%i in ("%CONDA_ROOT%") do set CONDA_ROOT_SHORT=%%~fsi
if "%CONDA_ROOT_POSIX%" == "" set CONDA_ROOT_POSIX=%CONDA_ROOT:\=/%
if "%CONDA_ROOT_SHORT_POSIX%" == "" set CONDA_ROOT_SHORT_POSIX=%CONDA_ROOT_SHORT:\=/%

if "%ACTIVATED_OSGF_ENV%" == "1" goto :EOF

REM Some convenience vars
set PF=%PROGRAMFILES%
set PF86=%PROGRAMFILES(x86)%
for %%i in ("%PROGRAMFILES%") do set PF_SHORT=%%~fsi
for %%i in ("%PROGRAMFILES(x86)%") do set PF86_SHORT=%%~fsi


REM ########## Activate conda env or fake it ##########

REM Don't mess with any standard conda env vars, if called during conda-build; skip to activation
REM Reload _h_env activate scripts (clobbered by conda-build's _build_env final activation)
if not "%CONDA_BUILD%" == "" goto reactivate

REM If we are already in a 'standard' activated env, don't mess with the env
if not "%CONDA_DEFAULT_ENV%" == "" goto :EOF


REM ###### Start manipulating env ##########

REM Standard Win Library locations
if "%LIBRARY_BIN%" == "" set "LIBRARY_BIN=%LIBRARY_PREFIX%\bin"
if "%LIBRARY_INC%" == "" set "LIBRARY_INC=%LIBRARY_PREFIX%\include"
if "%LIBRARY_LIB%" == "" set "LIBRARY_LIB=%LIBRARY_PREFIX%\lib"
if "%SCRIPTS%" == "" set "SCRIPTS=%CONDA_ROOT%\Scripts"

REM Load the prefix's environment
if exist "%CONDA_ROOT_SHORT%\Scripts\activate.bat" (

  set ACTIVATED_OSGF_ENV=1
  REM Load conda env via prefix, since conda package appears to be installed
  REM NOTE: this appears to exit this script, so ACTIVATED_OSGF_ENV is set first
  "%CONDA_ROOT_SHORT%\Scripts\activate.bat" "%CONDA_ROOT%"

) else (

  REM conda not available (e.g. bare pkgs installed from constructor, without conda package)
  REM Set up fake conda env...

  if "%CONDA_PYTHON_EXE%" == "" set "CONDA_PYTHON_EXE=%CONDA_ROOT_SHORT%\python.exe"
  set "PYTHONNOUSERSITE=1"
  if "%PYTHONIOENCODING%" == "" set "PYTHONIOENCODING=1252"

  REM These may not make sense if there is no root env as a parent to this install prefix
  REM set "SYS_PREFIX=%CONDA_ROOT_SHORT%"
  REM set "SYS_PYTHON=%CONDA_ROOT_SHORT%\python.exe"

  if "%STDLIB_DIR%" == "" set "STDLIB_DIR=%CONDA_ROOT_SHORT%\Lib"
  if "%SP_DIR%" == "" set "SP_DIR=%CONDA_ROOT_SHORT%\Lib\site-packages"

  set "PATH=%CONDA_ROOT%;%LIBRARY_PREFIX%\mingw-w64\bin;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_PREFIX%\bin;%CONDA_ROOT%\Scripts;%PATH%"

)

:reactivate

REM Activation scripts expect CONDA_PREFIX
if "%CONDA_PREFIX%" == "" set "CONDA_PREFIX=%CONDA_ROOT%"

REM Load activate scripts
if exist "%LIBRARY_PREFIX%\bin\reactivate_env.bat" call "%LIBRARY_PREFIX%\bin\reactivate_env.bat"

REM ###### Stop manipulating env ##########


set ACTIVATED_OSGF_ENV=1
