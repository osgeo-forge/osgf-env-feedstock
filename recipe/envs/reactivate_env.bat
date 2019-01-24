@echo off

REM Get grandparent of this script, converting UNC path to drive letter if needed
if "%CONDA_ROOT%" == "" for %%a in (%~dp0\..\..) do set CONDA_ROOT=%%~fa
if "%CONDA_ROOT_SHORT%" == "" for %%i in ("%CONDA_ROOT%") do set CONDA_ROOT_SHORT=%%~fsi

if "%ACTIVATED_CONDA_ENV%" == "1" goto :EOF

REM Load conda env activate scripts
if exist "%CONDA_ROOT_SHORT%\etc\conda\activate.d" (
  for %%G in ("%CONDA_ROOT_SHORT%\etc\conda\activate.d\*.bat") do call "%%G"
)

set ACTIVATED_CONDA_ENV=1
