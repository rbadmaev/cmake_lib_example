cmake_minimum_required(VERSION 3.26)

set(DETAILS_LIB_NAME Details)
set(PUBLIC_HEADERS
    DetailsPublic.h
)

set(SOURCES
    ${PUBLIC_HEADERS}
    DetailsPrivate.h
    DetailsPrivate.cpp
    DetailsPublic.cpp
)

add_library(${DETAILS_LIB_NAME} STATIC ${SOURCES})
set_target_properties(${DETAILS_LIB_NAME} PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}") # headers to export while instalation

# To allow use target headers in this repo
target_include_directories(${DETAILS_LIB_NAME}
                           PUBLIC
                           "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
)

install(TARGETS ${DETAILS_LIB_NAME}
        DESTINATION ${INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION ${INSTALL_INCLUDEDIR}/${PROJECT_NAME}) #force locate public headers in subfolder
