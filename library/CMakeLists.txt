cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib
        VERSION 1.0)

include(exportPackage.cmake)
set(PACKAGE_NAME ${PROJECT_NAME})
createPackage(${PACKAGE_NAME} ${PROJECT_VERSION})

add_subdirectory(MyLib)

exportPackage(${PACKAGE_NAME})

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()
