#!/usr/bin/env bats

testDir=`pwd`
echo "testDir: $testDir"
cd '..'
srcDir=`pwd`
echo "srcDir: $srcDir"
cd $testDir

@test "local build" {
    buildDir="$testDir/build"
    echo "buildDir: $buildDir"
    installPath="$buildDir/install"
    echo "installPath: $installPath"

    mkdir -p $buildDir/library
    cd $buildDir/library
    cmake -DCMAKE_INSTALL_PREFIX=$installPath $srcDir/library
    cmake --build .
    cmake --install .

    mkdir -p $buildDir/client
    cd $buildDir/client
    cmake -DCMAKE_PREFIX_PATH=$installPath $srcDir/client
    cmake --build .
}
