@echo off
REM This is a short-name, with no spaces, path
set GRASS_PARENT_DIR=%OSGEO4W_ROOT%\apps\grass

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
