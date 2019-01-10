REM NOTE: assumes this file is in CONDA_PREFIX\LIBRARY_PREFIX\bin


REM Some convenience vars
set PF=%PROGRAMFILES%
set PF86=%PROGRAMFILES(x86)%

REM Make parent of this script location our current directory,
REM converting UNC path to drive letter if needed
if "%LIBRARY_PREFIX%" == "" (
  pushd %~dp0
    cd ..
    REM Set LIBRARY_PREFIX to short path version
    for %%i in ("%CD%") do set LIBRARY_PREFIX=%%~fsi
  popd
)
if "%CONDA_PREFIX%" == "" (
  pushd %~dp0
    cd ..\..
    REM Set CONDA_PREFIX to short path version
    for %%i in ("%CD%") do set CONDA_PREFIX=%%~fsi
  popd
)

cd %~dp0

REM Standard Win Library locations
set "LIBRARY_BIN=%LIBRARY_PREFIX%\bin"
set "LIBRARY_INC=%LIBRARY_PREFIX%\include"
set "LIBRARY_LIB=%LIBRARY_PREFIX%\lib"
set "SCRIPTS=%CONDA_PREFIX%\Scripts"

REM Load the prefix's environment
if exist "%CONDA_PREFIX%\Scripts\activate.bat" (

  REM Load conda env via prefix
  "%CONDA_PREFIX%\Scripts\activate.bat" "%CONDA_PREFIX%"

) else (

  REM conda not available (e.g. bare pkgs installed from constructor)
  REM Set up fake conda env...

  set "CONDA_PYTHON_EXE=%CONDA_PREFIX%\python.exe"
  set "PYTHONNOUSERSITE=1"
  set "PYTHONIOENCODING=1252"
  set "SYS_PREFIX=%CONDA_PREFIX%"
  set "SYS_PYTHON=%CONDA_PREFIX%\python.exe"

  set "STDLIB_DIR=%CONDA_PREFIX%\Lib"
  set "SP_DIR=%CONDA_PREFIX%\Lib\site-packages"

  path "%CONDA_PREFIX%;%LIBRARY_PREFIX%\mingw-w64\bin;%LIBRARY_PREFIX%\usr\bin;%LIBRARY_BIN%;%SCRIPTS%;%PATH%"

  REM Load activate scripts
  if exist "%LIBRARY_PREFIX%\etc\conda\activate.d" (
    for %%f in ("%LIBRARY_PREFIX%\etc\conda\activate.d\*.bat") do call "%%f"
  )

)
