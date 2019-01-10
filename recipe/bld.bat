
:: osgeo-/conda-forge specific envs
copy osgf_env.bat %LIBRARY_BIN%
if %errorlevel% neq 0 exit /b %errorlevel%


:: OSGeo4W compatible envs
:: Large apps, e.g. QGIS, launch scripts look for these
for %%g in (o4w_env.bat py3_env.bat qt5_env.bat) do (
  copy %%g %LIBRARY_BIN%
  if %errorlevel% neq 0 exit /b %errorlevel%
)

exit /b 0
