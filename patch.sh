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

git_patchset="git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"
if [ -f ${DIR}/system.sh ] ; then
	. ${DIR}/system.sh
	if [ "${GIT_OVER_HTTP}" ] ; then
		git_patchset="http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git"
	fi
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

imx_next () {
	echo "dir: imx_next"
	${git} "${DIR}/patches/imx_next/0001-ARM-imx_v6_v7_defconfig-Select-PCI-support.patch"
	${git} "${DIR}/patches/imx_next/0002-ARM-imx-Use-INT_MEM_CLK_LPM-as-the-bit-name.patch"
	${git} "${DIR}/patches/imx_next/0003-ARM-imx-AHB-rate-must-be-set-to-132MHz-on-i.mx6sl.patch"
	${git} "${DIR}/patches/imx_next/0004-ARM-imx-add-cpuidle-support-for-i.mx6sl.patch"
	${git} "${DIR}/patches/imx_next/0005-ARM-imx_v6_v7_defconfig-Enable-backlight-gpio-suppor.patch"
	${git} "${DIR}/patches/imx_next/0006-ARM-i.MX35-build-in-pinctrl-support.patch"
	${git} "${DIR}/patches/imx_next/0007-ARM-imx_v6_v7_defconfig-Enable-some-drivers-used-on-.patch"
	${git} "${DIR}/patches/imx_next/0008-ARM-imx-add-select-on-ARCH_MXC-for-cpufreq-support.patch"
	${git} "${DIR}/patches/imx_next/0009-ARM-imx-clk-imx6sl-Suppress-duplicate-const-sparse-w.patch"
	${git} "${DIR}/patches/imx_next/0010-ARM-imx-clk-vf610-Suppress-duplicate-const-sparse-wa.patch"
	${git} "${DIR}/patches/imx_next/0011-ARM-i.MX-remove-PWM-platform-support.patch"
	${git} "${DIR}/patches/imx_next/0012-ARM-imx-add-suspend-in-ocram-support-for-i.mx6q.patch"
	${git} "${DIR}/patches/imx_next/0013-ARM-imx-add-suspend-in-ocram-support-for-i.mx6dl.patch"
	${git} "${DIR}/patches/imx_next/0014-ARM-imx-add-suspend-in-ocram-support-for-i.mx6sl.patch"
	${git} "${DIR}/patches/imx_next/0015-ARM-imx-add-always-on-clock-array-for-i.mx6sl-to-mai.patch"
	${git} "${DIR}/patches/imx_next/0016-ARM-imx-enable-delaytimer-on-the-imx-timer.patch"
#	${git} "${DIR}/patches/imx_next/0017-ARM-imx6-Initialize-low-power-mode-early-again.patch"
	${git} "${DIR}/patches/imx_next/0018-ARM-dts-i.MX53-Internal-keyboard-controller.patch"
	${git} "${DIR}/patches/imx_next/0019-ARM-dts-disable-flexcan-by-default.patch"
	${git} "${DIR}/patches/imx_next/0020-ARM-dts-add-Gateworks-Ventana-support.patch"
	${git} "${DIR}/patches/imx_next/0021-ARM-dts-imx6q-arm2-enable-USB-OTG.patch"
	${git} "${DIR}/patches/imx_next/0022-ARM-dts-Add-initial-support-for-cm-fx6.patch"
	${git} "${DIR}/patches/imx_next/0023-ARM-dts-imx6qdl-make-pinctrl-nodes-board-specific.patch"
	${git} "${DIR}/patches/imx_next/0024-ARM-dts-imx6sl-make-pinctrl-nodes-board-specific.patch"
	${git} "${DIR}/patches/imx_next/0025-ARM-dts-imx6-use-generic-node-name-for-fixed-regulat.patch"
	${git} "${DIR}/patches/imx_next/0026-DT-Add-Data-Modul-vendor-prefix.patch"
	${git} "${DIR}/patches/imx_next/0027-ARM-dts-imx6-Add-support-for-imx6q-dmo-edmqmx6.patch"
	${git} "${DIR}/patches/imx_next/0028-ARM-dts-imx6q-udoo-Add-Ethernet-support.patch"
	${git} "${DIR}/patches/imx_next/0029-ARM-dts-imx6q-sabrelite-Remove-duplicate-GPIO-entry.patch"
	${git} "${DIR}/patches/imx_next/0030-ARM-dts-imx-specify-the-value-of-audmux-pinctrl-inst.patch"
	${git} "${DIR}/patches/imx_next/0031-ARM-dts-imx-pinfunc-add-MX6QDL_PAD_SD1_CLK__OSC32K_3.patch"
	${git} "${DIR}/patches/imx_next/0032-ARM-dts-imx-imx6qdl.dtsi-add-mipi_csi-tag.patch"
	${git} "${DIR}/patches/imx_next/0033-ARM-dts-imx-imx6q.dtsi-use-IRQ_TYPE_LEVEL_HIGH.patch"
	${git} "${DIR}/patches/imx_next/0034-ARM-dts-imx-imx6dl.dtsi-use-IRQ_TYPE_LEVEL_HIGH.patch"
	${git} "${DIR}/patches/imx_next/0035-ARM-dts-imx-imx6sl.dtsi-use-IRQ_TYPE_LEVEL_HIGH.patch"
	${git} "${DIR}/patches/imx_next/0036-ARM-dts-imx-imx6qdl.dtsi-use-IRQ_TYPE_LEVEL_HIGH.patch"
	${git} "${DIR}/patches/imx_next/0037-ARM-dts-imx6q-sabrelite-Place-status-as-the-last-nod.patch"
	${git} "${DIR}/patches/imx_next/0038-ARM-dts-imx6q-sabrelite-Enable-PCI-express.patch"
	${git} "${DIR}/patches/imx_next/0039-ARM-dts-imx6qdl-add-aliases-for-can-interfaces.patch"
	${git} "${DIR}/patches/imx_next/0040-ARM-dts-imx-sabrelite-add-Dual-Lite-Solo-support.patch"
	${git} "${DIR}/patches/imx_next/0041-ARM-dts-imx6qdl-sabrelite-Add-uart1-support.patch"
	${git} "${DIR}/patches/imx_next/0042-ARM-dts-imx6qdl-sabrelite-remove-usdhc4-wp-gpio.patch"
	${git} "${DIR}/patches/imx_next/0043-ARM-dts-imx6qdl-add-spdif-support-for-sabreauto.patch"
	${git} "${DIR}/patches/imx_next/0044-ARM-dts-imx6qdl-sabrelite-move-USDHC4-CD-to-pinctrl_.patch"
	${git} "${DIR}/patches/imx_next/0045-ARM-dts-imx6qdl-sabrelite-move-USDHC3-CD-WP-to-pinct.patch"
	${git} "${DIR}/patches/imx_next/0046-ARM-dts-imx6qdl-sabrelite-move-spi-nor-CS-to-pinctrl.patch"
	${git} "${DIR}/patches/imx_next/0047-ARM-dts-imx6qdl-sabrelite-move-usbotg-power-enable-t.patch"
	${git} "${DIR}/patches/imx_next/0048-ARM-dts-imx6qdl-sabrelite-move-phy-reset-to-pinctrl_.patch"
	${git} "${DIR}/patches/imx_next/0049-ARM-dts-imx6qdl-sabrelite-explicitly-set-pad-for-SGT.patch"
	${git} "${DIR}/patches/imx_next/0050-ARM-dts-imx6qdl-sabrelite-add-pwms-for-backlights.patch"
	${git} "${DIR}/patches/imx_next/0051-ARM-dts-imx6qdl-sabrelite-add-skews-for-Micrel-phy.patch"
	${git} "${DIR}/patches/imx_next/0052-ARM-dts-imx6qdl-sabrelite-fix-ENET-group.patch"
	${git} "${DIR}/patches/imx_next/0053-ARM-dts-imx6qdl-sabrelite-Add-over-current-pin-to-us.patch"
	${git} "${DIR}/patches/imx_next/0054-ARM-dts-imx-add-nitrogen6x-board.patch"
	${git} "${DIR}/patches/imx_next/0055-ARM-dts-imx6qdl-sabrelite-add-gpio-keys.patch"
	${git} "${DIR}/patches/imx_next/0056-ARM-dts-imx6q-update-setting-of-VDDARM_CAP-voltage.patch"
	${git} "${DIR}/patches/imx_next/0057-ARM-dts-imx6q-add-vddsoc-pu-setpoint-info.patch"
	${git} "${DIR}/patches/imx_next/0058-ARM-dts-imx6dl-enable-cpufreq-support.patch"
	${git} "${DIR}/patches/imx_next/0059-ARM-dts-imx6qdl-add-necessary-thermal-clk.patch"
	${git} "${DIR}/patches/imx_next/0060-ARM-dts-imx6sl-Adding-cpu-frequency-and-VDDSOC-PU-ta.patch"
	${git} "${DIR}/patches/imx_next/0061-ARM-dts-imx6qdl-sabresd-Add-power-key-support.patch"
	${git} "${DIR}/patches/imx_next/0062-ARM-dts-imx6-Use-vddarm-as-the-regulator-name.patch"
	${git} "${DIR}/patches/imx_next/0063-ARM-dts-imx6q-sabrelite-PHY-reset-is-active-low.patch"
	${git} "${DIR}/patches/imx_next/0064-ARM-dts-imx-pinfunc-add-MX6QDL_PAD_GPIO_6__ENET_IRQ.patch"
	${git} "${DIR}/patches/imx_next/0065-ARM-dts-imx6qdl-use-interrupts-extended-for-fec.patch"
	${git} "${DIR}/patches/imx_next/0066-ARM-dts-mxs-add-auart2-pinmux-to-imx28.dtsi.patch"
	${git} "${DIR}/patches/imx_next/0067-of-add-vendor-prefix-for-Eukrea-Electromatique.patch"
	${git} "${DIR}/patches/imx_next/0068-ARM-dts-i.MX25-Add-ssi-clocks-and-DMA-events.patch"
	${git} "${DIR}/patches/imx_next/0069-ARM-dts-i.MX25-Add-sdma-script-path.patch"
	${git} "${DIR}/patches/imx_next/0070-ARM-dts-imx25.dtsi-Add-a-label-for-the-Audio-Multipl.patch"
	${git} "${DIR}/patches/imx_next/0071-ARM-dts-Add-support-for-the-cpuimx51-board-from-Eukr.patch"
	${git} "${DIR}/patches/imx_next/0072-ARM-dts-imx-add-device-tree-pin-definitions-for-the-.patch"
	${git} "${DIR}/patches/imx_next/0073-ARM-dts-imx-add-IMX50-SoC-device-tree.patch"
	${git} "${DIR}/patches/imx_next/0074-ARM-dts-imx-add-device-tree-support-for-Freescale-im.patch"
	${git} "${DIR}/patches/imx_next/0075-ARM-dts-Add-vendor-prefix-for-Voipac-Technologies-s..patch"
	${git} "${DIR}/patches/imx_next/0076-ARM-dts-i.MX53-dts-for-Voipac-x53-dmm-668-module.patch"
	${git} "${DIR}/patches/imx_next/0077-ARM-dts-i.MX53-Devicetree-for-Voipac-Baseboard-using.patch"
	${git} "${DIR}/patches/imx_next/0078-ARM-dts-imx53-make-pinctrl-nodes-board-specific.patch"
	${git} "${DIR}/patches/imx_next/0079-ARM-dts-imx51-make-pinctrl-nodes-board-specific.patch"
	${git} "${DIR}/patches/imx_next/0080-ARM-dts-vf610-make-pinctrl-nodes-board-specific.patch"
	${git} "${DIR}/patches/imx_next/0081-ARM-dts-imx53-mba53-create-a-container-for-fixed-reg.patch"
	${git} "${DIR}/patches/imx_next/0082-ARM-dts-imx-use-generic-node-name-for-fixed-regulato.patch"
	${git} "${DIR}/patches/imx_next/0083-ARM-dts-imx25-Add-pinctrl-functions.patch"
	${git} "${DIR}/patches/imx_next/0084-ARM-dts-imx25.dtsi-label-the-iomuxc.patch"
	${git} "${DIR}/patches/imx_next/0085-ARM-mxs-add-support-for-I2SE-s-duckbill-series.patch"
	${git} "${DIR}/patches/imx_next/0086-ARM-dts-i.MX51-Update-CPU-node.patch"
	${git} "${DIR}/patches/imx_next/0087-ARM-dts-i.MX51-Add-dummy-clock-to-AUDMUX.patch"
	${git} "${DIR}/patches/imx_next/0088-ARM-dts-i.MX51-Switch-to-use-standard-IRQ-flags-defi.patch"
	${git} "${DIR}/patches/imx_next/0089-ARM-imx27-apf27dev-Add-sdhci-support.patch"
	${git} "${DIR}/patches/imx_next/0090-ARM-dts-imx27-pin-functions.patch"
	${git} "${DIR}/patches/imx_next/0091-ARM-imx53-use-clock-defines-in-DTS-files.patch"
	${git} "${DIR}/patches/imx_next/0101-ARM-dts-imx53-Add-AHCI-SATA-DT-node.patch"
	${git} "${DIR}/patches/imx_next/0122-ARM-dts-imx53-Enable-AHCI-SATA-for-imx53-qsb.patch"
}

ahci () {
	echo "dir: ahci"
	${git} "${DIR}/patches/ahci/0001-libahci-Allow-drivers-to-override-start_engine.patch"
	${git} "${DIR}/patches/ahci/0002-libahci-Move-ahci_host_priv-declaration-to-include-l.patch"
	${git} "${DIR}/patches/ahci/0003-ahci-platform-Pass-ahci_host_priv-ptr-to-ahci_platfo.patch"
	${git} "${DIR}/patches/ahci/0004-ahci-platform-Add-support-for-devices-with-more-then.patch"
	${git} "${DIR}/patches/ahci/0005-ahci-platform-Add-support-for-an-optional-regulator-.patch"
	${git} "${DIR}/patches/ahci/0006-ahci-platform-Add-enable_-disable_resources-helper-f.patch"
	${git} "${DIR}/patches/ahci/0007-ahci-platform-Library-ise-ahci_probe-functionality.patch"
	${git} "${DIR}/patches/ahci/0008-ahci-platform-Library-ise-suspend-resume-functionali.patch"
	${git} "${DIR}/patches/ahci/0009-ARM-sunxi-Add-support-for-Allwinner-SUNXi-SoCs-sata-.patch"
	${git} "${DIR}/patches/ahci/0010-ahci-imx-Port-to-library-ised-ahci_platform.patch"
	${git} "${DIR}/patches/ahci/0011-ata-ahci_platform-Add-DT-compatible-for-Synopsis-DWC.patch"
	${git} "${DIR}/patches/ahci/0012-ata-ahci_platform-Update-DT-compatible-list.patch"
	${git} "${DIR}/patches/ahci/0013-ata-ahci_platform-Manage-SATA-PHY.patch"
	${git} "${DIR}/patches/ahci/0014-ata-ahci_platform-Add-struct-device-argument-to-ahci.patch"
	${git} "${DIR}/patches/ahci/0015-ata-ahci_platform-runtime-resume-the-device-before-u.patch"
}

imx_next
ahci

echo "patch.sh ran successful"
