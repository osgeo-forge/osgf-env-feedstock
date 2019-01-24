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

if "%ACTIVATED_QT5_ENV%" == "1" goto :EOF

REM This should already be on PATH
REM path %LIBRARY_PREFIX%\bin;%PATH%

set QT_PLUGIN_PATH=%LIBRARY_PREFIX%\plugins

set O4W_QT_PREFIX=%LIBRARY_PREFIX_POSIX%/
set O4W_QT_BINARIES=%LIBRARY_PREFIX_POSIX%/bin
set O4W_QT_PLUGINS=%LIBRARY_PREFIX_POSIX%/plugins
set O4W_QT_LIBRARIES=%LIBRARY_PREFIX_POSIX%/lib
set O4W_QT_TRANSLATIONS=%LIBRARY_PREFIX_POSIX%/translations
set O4W_QT_HEADERS=%LIBRARY_PREFIX_POSIX%/include/qt
set O4W_QT_DOC=%LIBRARY_PREFIX_POSIX%/doc

set ACTIVATED_QT5_ENV=1
