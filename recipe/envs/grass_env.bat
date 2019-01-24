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

if "%ACTIVATED_GRASS_ENV%" == "1" goto :EOF

REM This is a short-name, with no spaces, path
set GRASS_PARENT_DIR=%LIBRARY_PREFIX_SHORT%\apps\grass

if exist %GRASS_PARENT_DIR% (

  REM Should only be one subdirectory, otherwise may result in highest version
  pushd %GRASS_PARENT_DIR%
    for /d %%G in ("grass-*") do (
      set GISBASE_DIR=%%G
      goto continue
    )
    :continue
  popd

  if not "%GISBASE_DIR%"=="" if exist %GRASS_PARENT_DIR%\%GISBASE_DIR% (
    set GRASS_ROOT=%GRASS_PARENT_DIR:\=/%/%GISBASE_DIR%
    call %GRASS_PARENT_DIR%\%GISBASE_DIR%\etc\env.bat
  )

)

set ACTIVATED_GRASS_ENV=1
