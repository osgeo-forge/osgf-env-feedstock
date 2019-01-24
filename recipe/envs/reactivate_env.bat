@echo off
REM Get parent of parent of this script, converting UNC path to drive letter if needed
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

if "%ACTIVATED_CONDA_ENV%" == "1" goto :EOF

REM Load conda env activate scripts
if exist "%CONDA_ROOT_SHORT%\etc\conda\activate.d" (
  for %%G in ("%CONDA_ROOT_SHORT%\etc\conda\activate.d\*.bat") do call "%%G"
)

set ACTIVATED_CONDA_ENV=1
