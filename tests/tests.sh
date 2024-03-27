#!/usr/bin/env bats

set -e

testDir=`pwd`
cd '..'
srcDir=`pwd`
cd $testDir
buildsDir="$testDir/build"

@test "local build" {
    buildDir="$buildsDir/local"
    installPath="$buildDir/install"
    rm -rf $installPath/*

    mkdir -p $buildDir/library
    cd $buildDir/library && rm -rf ./*
    echo "--------- CONFIGURE LIB ---------------"
    cmake -DCMAKE_INSTALL_PREFIX=$installPath -DUseTests=True $srcDir/library
    echo "--------- BUILD LIB ---------------"
    cmake --build .
    echo "--------- UNIT TEST LIB ---------------"
    ctest .
    echo "--------- INSTALL LIB ---------------"
    cmake --install .

    echo "--------- CLIENT ---------------"
    mkdir -p $buildDir/client
    cd $buildDir/client && rm -rf ./*
    echo "--------- CONFIGURE CLIENT ---------------"
    cmake -DCMAKE_PREFIX_PATH=$installPath $srcDir/client
    echo "--------- BUILD CLIENT ---------------"
    cmake --build .
    echo "--------- UNIT TESTS CLIENT ---------------"
    ctest .
}

@test "movable install" {
    buildDir="$buildsDir/movable"
    movedInstallPath="$buildDir/install"
    rm -rf $movedInstallPath

    mkdir -p $buildDir/library
    originalInstallPath="$buildDir/library/install"
    cd $buildDir/library && rm -rf ./*
    echo "--------- CONFIGURE LIB ---------------"
    cmake -DCMAKE_INSTALL_PREFIX=$originalInstallPath -DUseTests=True $srcDir/library
    echo "--------- BUILD LIB ---------------"
    cmake --build .
    echo "--------- UNIT TEST LIB ---------------"
    ctest .
    echo "--------- INSTALL LIB ---------------"
    cmake --install .

    mv $originalInstallPath $movedInstallPath

    echo "--------- CLIENT ---------------"
    mkdir -p $buildDir/client
    cd $buildDir/client && rm -rf ./*
    echo "--------- CONFIGURE CLIENT ---------------"
    cmake -DCMAKE_PREFIX_PATH=$movedInstallPath $srcDir/client
    echo "--------- BUILD CLIENT ---------------"
    cmake --build .
    echo "--------- UNIT TESTS CLIENT ---------------"
    ctest .
}
