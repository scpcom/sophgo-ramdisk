#!/bin/bash

scriptdir=`dirname $0`
cd $scriptdir ; scriptdir=`pwd` ; cd - > /dev/null

echo $scriptdir
pushd $scriptdir

if [ -e ../../build/cvisetup.sh -a "X$SDK_VER" = X ]; then
  pushd ../.. > /dev/null
  source build/cvisetup.sh
  olddefconfig
  popd > /dev/null
fi

if [ "X$SDK_VER" != X ]; then
  export INITRAMFS_BASE=$SDK_VER
  if [ $SDK_VER = 32bit ]; then
    export INITRAMFS_BASE=glibc_arm
  elif [ $SDK_VER = 64bit ]; then
    export INITRAMFS_BASE=glibc_arm64
  fi
fi

export TARGET=arm-linux-gnueabihf
export CC=${TARGET}-gcc

if [ "X$CROSS_COMPILE_PATH" != "X" -a "X${CROSS_COMPILE}" != "X" ]; then
  if [ -e ${CROSS_COMPILE_PATH}/bin/${CROSS_COMPILE}gcc ]; then
    export TARGET=`echo ${CROSS_COMPILE} | sed s/'-$'/''/g`
    export CC=${CROSS_COMPILE_PATH}/bin/${CROSS_COMPILE}gcc
  fi
fi

export STATIC_ROOT=`readlink -f $(pwd)/${TARGET}-static`

pkgs=*
if [ "X$1" != "X" ]; then
  pkgs=$1
fi

for d in $pkgs ; do
  s=`basename $d`
  if [ -d $d -a -e $d/${s}.sh ]; then
    echo $d
    pushd $d > /dev/null
    ./${s}.sh
    popd > /dev/null
  fi
done

popd > /dev/null
