#!/usr/bin/env bats

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
    cmake -DCMAKE_INSTALL_PREFIX=$installPath $srcDir/library
    cmake --build .
    cmake --install .

    mkdir -p $buildDir/client
    cd $buildDir/client && rm -rf ./*
    cmake -DCMAKE_PREFIX_PATH=$installPath $srcDir/client
    cmake --build .
}

@test "movable install" {
    buildDir="$buildsDir/movable"
    movedInstallPath="$buildDir/install"
    rm -rf $movedInstallPath

    mkdir -p $buildDir/library
    originalInstallPath="$buildDir/library/install"
    cd $buildDir/library && rm -rf ./*
    cmake -DCMAKE_INSTALL_PREFIX=$originalInstallPath $srcDir/library
    cmake --build .
    cmake --install .

    mv $originalInstallPath $movedInstallPath

    mkdir -p $buildDir/client
    cd $buildDir/client && rm -rf ./*
    cmake -DCMAKE_PREFIX_PATH=$movedInstallPath $srcDir/client
    cmake --build .
}
