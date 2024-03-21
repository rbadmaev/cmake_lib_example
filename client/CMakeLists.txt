cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

# Create target for library in the client project
# Client should know about library type: static or shared
add_library(Lib STATIC IMPORTED)
# Client project should know about structure of installation of library
FILE(GLOB_RECURSE LIB_IMPORTEDS ${LIB_DIR}/lib/*)
foreach(LIB_FILE ${LIB_IMPORTEDS})
    set_target_properties(Lib PROPERTIES
        IMPORTED_LOCATION ${LIB_FILE})
endforeach()

set_target_properties(Lib PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${LIB_DIR}/include)

add_executable(example example.cpp)
target_link_libraries(example Lib)
