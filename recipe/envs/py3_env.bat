@echo off

REM Get grandparent of this script, converting UNC path to drive letter if needed
if "%CONDA_ROOT%" == "" for %%a in (%~dp0\..\..) do set CONDA_ROOT=%%~fa
if "%CONDA_ROOT_SHORT%" == "" for %%i in ("%CONDA_ROOT%") do set CONDA_ROOT_SHORT=%%~fsi

if "%ACTIVATED_PY3_ENV%" == "1" goto :EOF

REM Maybe inherit %PYTHONPATH% here? No, only per launch wrapper
set PYTHONPATH=
set "PYTHONHOME=%CONDA_ROOT%"
path %CONDA_ROOT%;%CONDA_ROOT%\Scripts;%PATH%

set ACTIVATED_PY3_ENV=1
