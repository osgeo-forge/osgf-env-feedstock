if "%CONDA_ROOT%" == "" (
  pushd %~dp0
    cd ..\..
    REM Set CONDA_ROOT to short path version
    for %%i in ("%CD%") do set CONDA_ROOT=%%~fsi
  popd
)

set PYTHONPATH=
set PYTHONHOME=%CONDA_ROOT%
path %CONDA_ROOT%;%CONDA_ROOT%\Scripts;%PATH%
