#!/bin/bash

if [ "X${INITRAMFS_BASE}" != "X" -a -e ../../initramfs/${INITRAMFS_BASE} ]; then
  SDK_PACKAGE_OUT=../../initramfs/${INITRAMFS_BASE}
  # TODO: real build
  STATIC_ROOT=${SDK_PACKAGE_OUT}
  if [ -e ../../rootfs/public/parted/${ARCH}/bin/parted ]; then
    STATIC_ROOT=../../rootfs/public/parted/${ARCH}
  fi
  if [ -e ${STATIC_ROOT}/bin/parted ]; then
    cp -p ${STATIC_ROOT}/bin/parted ${SDK_PACKAGE_OUT}/
  fi
fi
