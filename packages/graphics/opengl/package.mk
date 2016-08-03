################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2014 Alex Deryskyba (alex@codesnake.com)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="opengl"
case $OPENGL in
  mesa|imx-gpu-viv|bcm2835-firmware)
    PKG_VERSION="1"
    PKG_REV="1"
    PKG_ARCH="any"
    PKG_LICENSE="OSS"
    PKG_SITE="http://www.openelec.tv"
    PKG_URL=""
    PKG_DEPENDS_TARGET="toolchain $OPENGL"
    PKG_PRIORITY="optional"
    PKG_SECTION="virtual"
    PKG_SHORTDESC="opengl: virtual package to build OpenGL(X/ES) support"
    PKG_LONGDESC="opengl is a virtual package to build OpenGL(X/ES) support."
    ;;
  meson6)
    PKG_VERSION="$OPENGL-r5p1-01rel0-armhf"
    PKG_REV="1"
    PKG_ARCH="arm"
    PKG_LICENSE="nonfree"
    PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
    PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
    PKG_DEPENDS_TARGET="toolchain"
    PKG_PRIORITY="optional"
    PKG_SECTION="graphics"
    PKG_SHORTDESC="opengl-meson6: OpenGL ES pre-compiled libraries for Mali 400 GPUs found in Amlogic Meson6 SoCs"
    PKG_LONGDESC="opengl-meson6: OpenGL ES pre-compiled libraries for Mali 400 GPUs found in Amlogic Meson6 SoCs. The libraries could be found in a Linux buildroot released by Amlogic at http://openlinux.amlogic.com:8000/download/ARM/filesystem/. See the opengl package."
    ;;
  meson8)
    PKG_VERSION="$OPENGL-r5p1-01rel0-armhf"
    PKG_REV="1"
    PKG_ARCH="arm"
    PKG_LICENSE="nonfree"
    PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
    PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
    PKG_DEPENDS_TARGET="toolchain"
    PKG_PRIORITY="optional"
    PKG_SECTION="graphics"
    PKG_SHORTDESC="opengl-meson8: OpenGL ES pre-compiled libraries for Mali 450 GPUs found in Amlogic Meson8 SoCs"
    PKG_LONGDESC="opengl-meson8: OpenGL ES pre-compiled libraries for Mali 450 GPUs found in Amlogic Meson8 SoCs. The libraries could be found in a Linux buildroot released by Amlogic at http://openlinux.amlogic.com:8000/download/ARM/filesystem/. See the opengl package."
    ;;
esac

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing todo
}

if [ "$OPENGL" = "meson6" -o "$OPENGL" = "meson8" ]; then
  makeinstall_target() {
    mkdir -p $SYSROOT_PREFIX/usr/include
      cp -PR usr/include/* $SYSROOT_PREFIX/usr/include

    mkdir -p $SYSROOT_PREFIX/usr/lib
      cp -PR usr/lib/*.so* $SYSROOT_PREFIX/usr/lib

    mkdir -p $INSTALL/usr/lib
      cp -PR usr/lib/*.so* $INSTALL/usr/lib
  }
fi

if [ ! "$OPENGL" = "mesa" ]; then
  post_install() {
    enable_service unbind-console.service
  }
fi