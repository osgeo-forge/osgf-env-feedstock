
:: osgeo-/conda-forge specific envs
copy osgf_env.bat %LIBRARY_BIN%
if %errorlevel% neq 0 exit /b %errorlevel%

set "CONDA_ACTIVATE_D=%LIBRARY_PREFIX%\etc\conda\activate.d"
if not exist "%CONDA_ACTIVATE_D%" mkdir "%CONDA_ACTIVATE_D%"
copy dummy.bat "%CONDA_ACTIVATE_D%"


:: OSGeo4W compatible envs
:: Large apps, e.g. QGIS, have wrapper launch scripts that use these
for %%g in (o4w_env.bat py3_env.bat qt5_env.bat) do (
  copy %%g %LIBRARY_BIN%
  if %errorlevel% neq 0 exit /b %errorlevel%
)

set "LIBRARY_INI=%LIBRARY_PREFIX%\etc\ini"
if not exist "%LIBRARY_INI%" mkdir "%LIBRARY_INI%"
copy dummy.bat "%LIBRARY_INI%"

exit /b 0
