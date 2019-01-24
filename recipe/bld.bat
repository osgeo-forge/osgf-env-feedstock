:: OSGeo-Forge and OSGeo4W compatible envs
pushd envs
  :: Large apps, e.g. QGIS, have wrapper launch scripts that use these
  :: !!! Ensure all .env files do not reference anything < major versions !!!
  for %%G in ("*.bat") do (
    copy /y %%G %LIBRARY_BIN%
    if %errorlevel% neq 0 exit /b %errorlevel%
  )
popd

:: Ensure a *.bat files can be found

set "CONDA_ACTIVATE_D=%PREFIX%\etc\conda\activate.d"
if not exist "%CONDA_ACTIVATE_D%" md "%CONDA_ACTIVATE_D%"
copy /y dummy.bat "%CONDA_ACTIVATE_D%"

:: Old-style OSGeo4W ini\*.env support (just in case)
set "LIBRARY_INI=%LIBRARY_PREFIX%\etc\ini"
if not exist "%LIBRARY_INI%" md "%LIBRARY_INI%"
copy /y dummy.bat "%LIBRARY_INI%"

exit /b 0
