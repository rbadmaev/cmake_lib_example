cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib)

set(PACKAGE_CONFIGS_INSTALL_DIR cmake)

add_subdirectory(MyLib)

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()
