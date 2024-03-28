cmake_minimum_required(VERSION 3.26)
project(MyLib)

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
target_link_libraries(${PROJECT_NAME} PRIVATE MyLibDetails)
set_target_properties(${PROJECT_NAME}
    PROPERTIES PUBLIC_HEADER "${PUBLIC_HEADERS}") # headers to export while instalation

# To allow use target headers in this repo
target_include_directories(${PROJECT_NAME}
                           PUBLIC
                           "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
)

# Implicit dependency.
# There is supposed that:
#  - exportPackage.cmake already included
#  - variable PACKAGE_NAME is exists
#  - package with name PACKAGE_NAME already created.
exportTarget(${PACKAGE_NAME} ${PROJECT_NAME})
