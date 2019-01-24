@echo off
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

if "%ACTIVATED_PY3_ENV%" == "1" goto :EOF

REM Maybe inherit %PYTHONPATH% here?
set PYTHONPATH=
set "PYTHONHOME=%CONDA_ROOT%"
path %CONDA_ROOT;%CONDA_ROOT%\Scripts;%PATH%

set ACTIVATED_PY3_ENV=1
