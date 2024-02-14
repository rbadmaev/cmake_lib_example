cmake_minimum_required(VERSION 3.26)
project(SuperCoolLib)

# Customizable target parameters
set(TARGET_NAME MyLib)
set(TARGET_VERSION "1.0.0")
#

# Customizable package parameters
set(PACKAGE_NAME ${TARGET_NAME})
set(PACKAGE_VERSION_STR ${TARGET_VERSION})
set(PACKAGE_CONFIGS_INSTALL_DIR cmake/)
#

set(TARGET_EXPORT_NAME ${PACKAGE_NAME}Targets)

add_subdirectory(${TARGET_NAME})

if (${UseTests})
    enable_testing() # Should be called here to allow run tests from build_root
    add_subdirectory(test)
endif()

# Installation and packaging
install(EXPORT ${TARGET_EXPORT_NAME}
    FILE ${TARGET_EXPORT_NAME}.cmake
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
