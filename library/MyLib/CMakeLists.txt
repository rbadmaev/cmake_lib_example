cmake_minimum_required(VERSION 3.26)
project(MyLib
    VERSION 1.0)

include(GNUInstallDirs)

# install each target to separate folder to avoid accidentally using files of another target
set(INSTALL_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/${CMAKE_INSTALL_INCLUDEDIR})
set(INSTALL_LIBDIR ${CMAKE_INSTALL_PREFIX}/${PROJECT_NAME}/${CMAKE_INSTALL_LIBDIR})

add_subdirectory(details)
set(PUBLIC_HEADERS
    MyLibPublic.h
)

set(SOURCES
    ${PUBLIC_HEADERS}
    MyLibPrivate.h
    MyLib.cpp
)

add_library(${PROJECT_NAME} STATIC ${SOURCES})
target_link_libraries(${PROJECT_NAME} PRIVATE Details)
set_target_properties(${PROJECT_NAME}
    PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}") # headers to export while instalation

# To allow use target headers in this repo
target_include_directories(${PROJECT_NAME}
                           PUBLIC
                           "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
)

install(TARGETS ${PROJECT_NAME}
        DESTINATION ${INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${INSTALL_INCLUDEDIR}/${PROJECT_NAME}) #force locate public headers in subfolder

# CMake package description is a two files: config and config version.
# Use CMakePackageConfigHelpers to generate this files
include(CMakePackageConfigHelpers)

configure_package_config_file(
    MyLibConfig.cmake.in # config template. Should contain imported target description
    ${PACKAGE_CONFIGS_DIR}/MyLibConfig.cmake # path to store generated config
    INSTALL_DESTINATION "${PACKAGE_CONFIGS_INSTALL_DIR}" # must be ${PACKAGE_CONFIGS_INSTALL_DIR} due to implicit contract
    PATH_VARS INSTALL_INCLUDEDIR INSTALL_LIBDIR) # variables which can be used in template
write_basic_package_version_file(
    ${PACKAGE_CONFIGS_DIR}/MyLibConfigVersion.cmake # path to store generated config
    # VERSION x.y.z # defaulted to PROJECT_VERSION
    COMPATIBILITY SameMinorVersion)

