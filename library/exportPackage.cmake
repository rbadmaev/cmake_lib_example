include(GNUInstallDirs)


function(_getPackagePaths PACKAGE_NAME)
    set(PACKAGE_PARTS_CONFIGS_DIR "${CMAKE_BINARY_DIR}/${PACKAGE_NAME}_cmake_parts" PARENT_SCOPE)
    set(PACKAGE_CONFIGS_INSTALL_DIR cmake PARENT_SCOPE)
endfunction()


function(createPackage PACKAGE_NAME PACKAGE_VERSION)
    _getPackagePaths(${PACKAGE_NAME})
    file(WRITE "${PACKAGE_PARTS_CONFIGS_DIR}/version" "${PACKAGE_VERSION}")
endfunction()


function(exportTarget PACKAGE_NAME TARGET_NAME)
    _getPackagePaths(${PACKAGE_NAME})
    get_target_property(TARGET_TYPE ${TARGET_NAME} TYPE)
    if (TARGET_TYPE STREQUAL "STATIC_LIBRARY")
        set (TARGET_TYPE "STATIC")
    elseif(TARGET_TYPE STREQUAL "DYNAMIC_LIBRARY")
        set (TARGET_TYPE "DYNAMIC")
    endif()

    # install target to approprite paths
    set(INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/${TARGET_NAME})
    set(INSTALL_INCLUDEDIR ${INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR})
    set(INSTALL_LIBDIR ${INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR})
    install(TARGETS ${TARGET_NAME}
        DESTINATION ${INSTALL_LIBDIR}/${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${INSTALL_INCLUDEDIR}/${PROJECT_NAME}) #force locate public headers in subfolder

    # prepare target description to temporary config file
    set(EXPORTED_TARGET_NAME "${PACKAGE_NAME}::${TARGET_NAME}")
    include(CMakePackageConfigHelpers)
    configure_package_config_file(
        ${CMAKE_SOURCE_DIR}/Config.cmake.template
        ${PACKAGE_PARTS_CONFIGS_DIR}/${TARGET_NAME}Config.cmake # path to store generated temp config
        INSTALL_DESTINATION "${PACKAGE_CONFIGS_INSTALL_DIR}"
        PATH_VARS INSTALL_INCLUDEDIR INSTALL_LIBDIR
    )
endfunction()


function(exportPackage PACKAGE_NAME)
    _getPackagePaths(${PACKAGE_NAME})
    set(GLOBAL_PACKAGE_CONFIG_FILE "${PACKAGE_PARTS_CONFIGS_DIR}/${PACKAGE_NAME}Config.cmake.in")
    set(PACKAGE_CONFIGS_DIR ${CMAKE_BINARY_DIR}/${PACKAGE_CONFIGS_INSTALL_DIR})

    file(WRITE ${GLOBAL_PACKAGE_CONFIG_FILE} "@PACKAGE_INIT@")
    FILE(GLOB_RECURSE TARGET_CONFIGS "${PACKAGE_PARTS_CONFIGS_DIR}/*Config.cmake")
    foreach(TARGET_CONFIG ${TARGET_CONFIGS})
        file(READ ${TARGET_CONFIG} CONTENT)
        file(APPEND ${GLOBAL_PACKAGE_CONFIG_FILE} "${CONTENT}")
    endforeach()

    include(CMakePackageConfigHelpers)
    configure_package_config_file(
        ${GLOBAL_PACKAGE_CONFIG_FILE}
        ${PACKAGE_CONFIGS_DIR}/${PACKAGE_NAME}Config.cmake # path to store generated config
        INSTALL_DESTINATION "${PACKAGE_CONFIGS_INSTALL_DIR}"
    )

    FILE(READ "${PACKAGE_PARTS_CONFIGS_DIR}/version" PACKAGE_VERSION)
    write_basic_package_version_file(
        ${PACKAGE_CONFIGS_DIR}/${PACKAGE_NAME}ConfigVersion.cmake # path to store generated config
        VERSION ${PACKAGE_VERSION}
        COMPATIBILITY SameMinorVersion)

    install(DIRECTORY ${PACKAGE_CONFIGS_DIR} DESTINATION .)
endfunction()
