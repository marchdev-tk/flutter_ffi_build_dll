@ECHO off

ECHO "Starting building dll..."

SET lib_project_name=%1
SET lib_name=%2

IF NOT defined lib_project_name (
    ECHO "lib_project_name wasn't privided!"
    exit 1
)
IF NOT defined lib_name (
    ECHO "lib_name wasn't privided!"
    exit 1
)

ECHO "lib_project_name=%lib_project_name%"
ECHO "lib_name=%lib_name%"

SHIFT & SHIFT

:loop
IF NOT "%1"=="" (
    IF "%1"=="-vs_build_path" (
        SET vs_build_path=%2
        SHIFT
    )
    IF "%1"=="-cmake_path" (
        SET cmake=%2
        SHIFT
    )
    SHIFT
    GOTO :loop
)

IF NOT defined vs_build_path SET vs_build_path="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build"
IF NOT defined cmake SET cmake="C:\Program Files\CMake\bin\cmake.exe"

ECHO "vs_build_path=%vs_build_path%"
ECHO "cmake=%cmake%"

ECHO "Initializing Visual Studio build environment..."
CALL %vs_build_path%\vcvars64.bat

ECHO "Creating solution..."
%cmake% nmake "%lib_project_name%\CMakeLists.txt"

ECHO "Building solution..."
msbuild "%lib_project_name%\%lib_project_name%.sln" /property:Configuration=Release

ECHO "Copying dll to %lib_project_name%..."
COPY "%lib_project_name%\Release\%lib_name%.dll" "%lib_project_name%"

ECHO "Removing solution files..."
FOR /R "%lib_project_name%" %%f IN (*) DO (IF NOT "%%~xf"==".h" IF NOT "%%~xf"==".c" IF NOT "%%~xf"==".cpp" IF NOT "%%~xf"==".def" IF NOT "%%~xf"==".dll" IF NOT "%%~xf"==".gitignore" IF NOT "%%~nxf"=="CMakeLists.txt" DEL "%%~f")
FOR /D %%d IN ("%lib_project_name%\*.*") DO RMDIR "%%d" /s /q

ECHO "Done!"