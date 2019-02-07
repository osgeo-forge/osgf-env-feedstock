@echo off

REM Get parent of this script, converting UNC path to drive letter if needed
if "%LIBRARY_PREFIX%" == "" for %%a in (%~dp0\..) do set LIBRARY_PREFIX=%%~fa
if "%LIBRARY_PREFIX_SHORT%" == "" for %%i in ("%LIBRARY_PREFIX%") do set LIBRARY_PREFIX_SHORT=%%~fsi
if "%LIBRARY_PREFIX_POSIX%" == "" set LIBRARY_PREFIX_POSIX=%LIBRARY_PREFIX:\=/%
if "%LIBRARY_PREFIX_SHORT_POSIX%" == "" set LIBRARY_PREFIX_SHORT_POSIX=%LIBRARY_PREFIX_SHORT:\=/%

if "%ACTIVATED_QT5_ENV%" == "1" goto :EOF

REM This should already be on PATH
REM path %LIBRARY_PREFIX%\bin;%PATH%

set "QT_PLUGIN_PATH=%LIBRARY_PREFIX%\plugins"

set "O4W_QT_PREFIX=%LIBRARY_PREFIX_POSIX%/"
set "O4W_QT_BINARIES=%LIBRARY_PREFIX_POSIX%/bin"
set "O4W_QT_PLUGINS=%LIBRARY_PREFIX_POSIX%/plugins"
set "O4W_QT_LIBRARIES=%LIBRARY_PREFIX_POSIX%/lib"
set "O4W_QT_TRANSLATIONS=%LIBRARY_PREFIX_POSIX%/translations"
set "O4W_QT_HEADERS=%LIBRARY_PREFIX_POSIX%/include/qt"
set "O4W_QT_DOC=%LIBRARY_PREFIX_POSIX%/doc"

set ACTIVATED_QT5_ENV=1
