cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

find_package(SuperCoolLib 1.0 EXACT REQUIRED MyLib)

add_executable(example example.cpp)
target_link_libraries(example SuperCoolLib::MyLib)
