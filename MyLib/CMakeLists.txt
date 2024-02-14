cmake_minimum_required(VERSION 3.26)
project(MyLib)

include(GNUInstallDirs)

set(LIB_NAME MyLib)
set(PUBLIC_HEADERS
    MyLibPublic.h
)

set(SOURCES
    ${PUBLIC_HEADERS}
    MyLibPrivate.h
    MyLib.cpp
)

add_library(${LIB_NAME} STATIC ${SOURCES})
set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}") # headers to export while instalation

# To allow use target headers in this repo
target_include_directories(${LIB_NAME}
                           PUBLIC
                           "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
                           "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

install(TARGETS ${LIB_NAME}
        EXPORT SuperCoolLib
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${LIB_NAME}) #force locate public headers in subfolder
