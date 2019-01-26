@echo off

REM Get parent of this script, converting UNC path to drive letter if needed
if "%LIBRARY_PREFIX%" == "" for %%a in (%~dp0\..) do set LIBRARY_PREFIX=%%~fa
if "%LIBRARY_PREFIX_SHORT%" == "" for %%i in ("%LIBRARY_PREFIX%") do set LIBRARY_PREFIX_SHORT=%%~fsi
if "%LIBRARY_PREFIX_POSIX%" == "" set LIBRARY_PREFIX_POSIX=%LIBRARY_PREFIX:\=/%
if "%LIBRARY_PREFIX_SHORT_POSIX%" == "" set LIBRARY_PREFIX_SHORT_POSIX=%LIBRARY_PREFIX_SHORT:\=/%

REM Get grandparent of this script, converting UNC path to drive letter if needed
if "%CONDA_ROOT%" == "" for %%a in ("%LIBRARY_PREFIX%\..") do set CONDA_ROOT=%%~fa
if "%CONDA_ROOT_SHORT%" == "" for %%i in ("%CONDA_ROOT%") do set CONDA_ROOT_SHORT=%%~fsi
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
