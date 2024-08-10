#!/bin/bash

if [ "X${INITRAMFS_BASE}" != "X" -a -e ../../initramfs/${INITRAMFS_BASE} ]; then
  SDK_PACKAGE_OUT=../../initramfs/${INITRAMFS_BASE}
  # TODO: real build
  STATIC_ROOT=${SDK_PACKAGE_OUT}
  if [ -e ${STATIC_ROOT}/bin/busybox ]; then
    cp -p ${STATIC_ROOT}/bin/busybox ${SDK_PACKAGE_OUT}/
  fi
fi
