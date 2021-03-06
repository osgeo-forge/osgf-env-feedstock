@echo off

REM Get parent of this script, converting UNC path to drive letter if needed
if "%LIBRARY_PREFIX%" == "" for %%a in (%~dp0\..) do set LIBRARY_PREFIX=%%~fa

REM Get grandparent of this script, converting UNC path to drive letter if needed
if "%CONDA_ROOT%" == "" for %%a in ("%LIBRARY_PREFIX%\..") do set CONDA_ROOT=%%~fa

if "%ACTIVATED_PY3_ENV%" == "1" goto :EOF

REM Maybe inherit %PYTHONPATH% here? No, only per launch wrapper
REM %CONDA_ROOT%\site-packages is for constructor install of py pkgs in wrong place
set "PYTHONPATH=%CONDA_ROOT%\site-packages;%CONDA_ROOT%\Lib\site-packages"
set "PYTHONHOME=%CONDA_ROOT%"
set "PATH=%CONDA_ROOT%;%CONDA_ROOT%\Scripts;%PATH%"

set ACTIVATED_PY3_ENV=1
