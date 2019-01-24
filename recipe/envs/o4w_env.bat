@echo off
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

set "OSGEO4W_ROOT=%LIBRARY_PREFIX%"

if "%ACTIVATED_O4W_ENV%" == "1" goto :EOF

REM start with clean path (we use any conda env's activate script, or fake it)
REM set path=%OSGEO4W_ROOT%\bin;%WINDIR%\system32;%WINDIR%;%WINDIR%\system32\WBem

REM These ini files should not exist, unless they have not be converted to conda
REM   scripts yet and they are artifacts from OSGeo4W builds
for %%f in ("%LIBRARY_PREFIX_SHORT%\etc\ini\*.bat") do call "%%f"

REM Load osgeo-/conda-forge environ(s), OVERRIDING environs above
if exist "%LIBRARY_PREFIX_SHORT%\bin\osgf_env.bat" call "%LIBRARY_PREFIX_SHORT%\bin\osgf_env.bat"

set ACTIVATED_O4W_ENV=1
