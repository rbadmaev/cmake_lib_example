cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib)

include(GNUInstallDirs)

# Customizable package parameters
set(PACKAGE_NAME SuperCoolLib)
set(PACKAGE_VERSION_STR "1.0.0")
set(PACKAGE_CONFIGS_INSTALL_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PACKAGE_NAME}/)
set(PACKAGE_NAMESPACE_NAME ${PACKAGE_NAME})
#

# Use this in 'install(TARGETS <target> EXPORT ${TARGETS_EXPORT_NAME} ...)
set(TARGETS_EXPORT_NAME ${PACKAGE_NAME}Targets)

add_subdirectory(MyLib)

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()

# Installation and packaging
install(EXPORT ${TARGETS_EXPORT_NAME}
    FILE ${TARGETS_EXPORT_NAME}.cmake
    NAMESPACE ${PACKAGE_NAMESPACE_NAME}::
    DESTINATION ${PACKAGE_CONFIGS_INSTALL_DIR})

include(CMakePackageConfigHelpers)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}Config.cmake"
    INSTALL_DESTINATION ${PACKAGE_CONFIGS_INSTALL_DIR}
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}ConfigVersion.cmake"
  VERSION ${PACKAGE_VERSION_STR}
  COMPATIBILITY AnyNewerVersion
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}Config.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/${PACKAGE_NAME}ConfigVersion.cmake"
  DESTINATION ${PACKAGE_CONFIGS_INSTALL_DIR}
  )
