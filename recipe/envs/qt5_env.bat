@echo off
REM path %OSGEO4W_ROOT%\apps\qt5\bin;%PATH%

set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\plugins

set O4W_QT_PREFIX=%OSGEO4W_ROOT:\=/%/
set O4W_QT_BINARIES=%OSGEO4W_ROOT:\=/%/bin
set O4W_QT_PLUGINS=%OSGEO4W_ROOT:\=/%/plugins
set O4W_QT_LIBRARIES=%OSGEO4W_ROOT:\=/%/lib
set O4W_QT_TRANSLATIONS=%OSGEO4W_ROOT:\=/%/translations
set O4W_QT_HEADERS=%OSGEO4W_ROOT:\=/%/include/qt
set O4W_QT_DOC=%OSGEO4W_ROOT:\=/%/doc
