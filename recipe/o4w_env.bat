REM Make parent of this script location our current directory,
REM converting UNC path to drive letter if needed
pushd %~dp0
  cd ..
  REM set OSGEO4W_ROOT to short path version
  for %%i in ("%CD%") do set OSGEO4W_ROOT=%%~fsi

  cd ..
  REM set CONDA_ROOT to short path version
  for %%i in ("%CD%") do set CONDA_ROOT=%%~fsi
popd

REM start with clean path (we use any conda env's activate script, or fake it)
REM set path=%OSGEO4W_ROOT%\bin;%WINDIR%\system32;%WINDIR%;%WINDIR%\system32\WBem

REM These ini files should not exist, unless they have not be converted to conda
REM   scripts yet and they are artifacts from OSGeo4W builds
for %%f in ("%OSGEO4W_ROOT%\etc\ini\*.bat") do call "%%f"

REM Load osgeo-/conda-forge environ(s), OVERRIDING environs above
if exist "%OSGEO4W_ROOT%\bin\osgf_env.bat" call "%OSGEO4W_ROOT%\bin\osgf_env.bat"

