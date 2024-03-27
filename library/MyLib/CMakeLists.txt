cmake_minimum_required(VERSION 3.26)
project(MyLib)

include(GNUInstallDirs)

set(LIB_NAME MyLib)

# install each target to separate folder to avoid accidentally using files of another target
set(INSTALL_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/MyLib/${CMAKE_INSTALL_INCLUDEDIR})
set(INSTALL_LIBDIR ${CMAKE_INSTALL_PREFIX}/MyLib/${CMAKE_INSTALL_LIBDIR})

add_subdirectory(details)
set(PUBLIC_HEADERS
    MyLibPublic.h
)

set(SOURCES
    ${PUBLIC_HEADERS}
    MyLibPrivate.h
    MyLib.cpp
)

add_library(${LIB_NAME} STATIC ${SOURCES})
target_link_libraries(${LIB_NAME} PRIVATE Details)
set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}") # headers to export while instalation

# To allow use target headers in this repo
target_include_directories(${LIB_NAME}
                           PUBLIC
                           "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
)

install(TARGETS ${LIB_NAME}
        DESTINATION ${INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${INSTALL_INCLUDEDIR}/${LIB_NAME}) #force locate public headers in subfolder

# CMake package description is a two files: config and config version.
# Use CMakePackageConfigHelpers to generate this files
include(CMakePackageConfigHelpers)

configure_package_config_file(
    MyLibConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/cmake/MyLibConfig.cmake
    INSTALL_DESTINATION ${PACKAGE_CONFIGS_INSTALL_DIR}
    PATH_VARS INSTALL_INCLUDEDIR INSTALL_LIBDIR)
configure_file(MyLibConfigVersion.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/cmake/MyLibConfigVersion.cmake @ONLY)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake DESTINATION .)
