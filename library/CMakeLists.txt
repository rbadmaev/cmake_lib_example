cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib
        VERSION 1.0)

include(exportPackage.cmake)

add_subdirectory(MyLib)

createExportedPackage()

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()
