# Batch Script for building Windows DLL via Dart FFI

This batch script will build C/C++ library based on CMake file and Visual Studio msbuild complier.

## In order to use this script follow this instructions:

  1. First of all you should provide `Library Project Name` *(it's just a folder name, where your C/C++ files are lies)*

  2. Then `Lib Name` should be given, without `.dll` specification, this name could be found in `CMakeLists.txt` file

### And now it should be something like this: **.\flutter_build_dll.bat hello_library hello**

  3. If you have installed Visual Studio in a different directory then a default one, you can specify path via `vs_build_path` flag as follows:
  
      **.\flutter_build_dll.bat hello_library hello `-vs_build_path "C:\bla\bla\bla"`**
      By the way, default path is: *C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build*
      
  4. And if you have installed CMake in a different directory then a default one, you can specify path via `cmake` flag as follows:
  
      **.\flutter_build_dll.bat hello_library hello `-cmake "C:\bla\bla\bla"`**
      By the way, default path is: *C:\Program Files\CMake\bin\cmake.exe*
      
Both flags `vs_build_path` and `cmake` could be used both together and separately.
