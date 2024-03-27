cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib
        VERSION 1.0)

# implicit contract:
# 1. packages should store their configs in ${PACKAGE_CONFIGS_DIR}
# 2. pakages should  use ${PACKAGE_CONFIGS_INSTALL_DIR} as INSTALL_DESTINATION of configure_package_config_file
set(PACKAGE_CONFIGS_INSTALL_DIR cmake)
set(PACKAGE_CONFIGS_DIR ${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_CONFIGS_INSTALL_DIR})

add_subdirectory(MyLib)

install(DIRECTORY ${PACKAGE_CONFIGS_DIR} DESTINATION .)

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()
