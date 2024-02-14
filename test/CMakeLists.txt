cmake_minimum_required(VERSION 3.26)
set(TEST_APP "MyLibTests")

find_package(
    Boost 1.77.0 EXACT
    REQUIRED
    COMPONENTS
        unit_test_framework
    )

set(SOURCES
    MyLibTest.cpp
    TestMain.cpp
)

add_executable(${TEST_APP} ${SOURCES})
target_link_libraries(${TEST_APP} PRIVATE MyLib Boost::unit_test_framework)

add_test(NAME FirstTest
         COMMAND ${TEST_APP} --log_level=unit_scope)

