#!/bin/bash
pkgver=1.47.1

if [ ! -e e2fsprogs-${pkgver} ]; then
  wget -O e2fsprogs-${pkgver}.tar.gz https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${pkgver}/e2fsprogs-${pkgver}.tar.gz/download 

  tar xzf e2fsprogs-${pkgver}.tar.gz
fi

pushd e2fsprogs-${pkgver}

mkdir -p build
pushd build
../configure --host="${TARGET}" --prefix="${STATIC_ROOT}" \
  --with-crond-dir="${STATIC_ROOT}/etc/cron.d" \
  --with-systemd-unit-dir="${STATIC_ROOT}/lib/systemd/system" \
  --with-udev-rules-dir="${STATIC_ROOT}/lib/udev/rules.d" \
  --enable-libuuid LDFLAGS="-static"
make
make install-strip
popd

popd

if [ "X${INITRAMFS_BASE}" != "X" -a -e ../../initramfs/${INITRAMFS_BASE} ]; then
  SDK_PACKAGE_OUT=../../initramfs/${INITRAMFS_BASE}
  cp -p ${STATIC_ROOT}/sbin/e2fsck ${SDK_PACKAGE_OUT}/
  cp -p ${STATIC_ROOT}/sbin/resize2fs ${SDK_PACKAGE_OUT}/
fi
