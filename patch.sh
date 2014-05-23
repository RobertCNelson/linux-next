#!/bin/sh
#
# Copyright (c) 2009-2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Split out, so build_kernel.sh and build_deb.sh can share..

git="git am"

git_patchset="https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
fi

. ${DIR}/version.sh

if [ "${RUN_BISECT}" ] ; then
	git="git apply"
fi

echo "Starting patch.sh"

git_add () {
	git add .
	git commit -a -m 'testing patchset'
}

start_cleanup () {
	git="git am --whitespace=fix"
}

cleanup () {
	if [ "${number}" ] ; then
		git format-patch -${number} -o ${DIR}/patches/
	fi
	exit
}

next () {
	echo "pulling: next-${tag}"
	git pull ${GIT_OPTS} ${git_patchset} next-${tag}

#	${git} "${DIR}/patches/next/0001-clk-sunxi-factors-automatic-reparenting-support.patch"
#	${git} "${DIR}/patches/next/0002-clk-sunxi-Implement-MMC-phase-control.patch"
#	${git} "${DIR}/patches/next/0003-ARM-sunxi-clk-export-clk_sunxi_mmc_phase_control.patch"
#	${git} "${DIR}/patches/next/0004-ARM-sunxi-Add-driver-for-SD-MMC-hosts-found-on-Allwi.patch"
#	${git} "${DIR}/patches/next/0005-ARM-dts-sun7i-Add-support-for-mmc.patch"
#	${git} "${DIR}/patches/next/0006-ARM-dts-sun4i-Add-support-for-mmc.patch"
#	${git} "${DIR}/patches/next/0007-ARM-dts-sun5i-Add-support-for-mmc.patch"
#	${git} "${DIR}/patches/next/0008-ARM-sunxi-Add-documentation-for-driver-for-SD-MMC-ho.patch"
#	${git} "${DIR}/patches/next/0009-arm-dts-sun4i-a10-olinuxino-lime-enable-mmc0.patch"
}

example () {
	echo "dir: dir"
	#${git} "${DIR}/patches/dir/0001-patch.patch"
}

next

echo "patch.sh ran successful"
