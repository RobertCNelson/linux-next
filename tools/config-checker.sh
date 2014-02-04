#!/bin/sh -e

DIR=$PWD

check_config_value () {
	unset test_config
	test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=${value} >> ./KERNEL/.config"
	else
		if [ ! "x${test_config}" = "x${config}=${value}" ] ; then
			echo "sed -i -e 's:${test_config}:${config}=${value}:g' ./KERNEL/.config"
		fi
	fi
}

check_config_builtin () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
	fi
}

check_config_module () {
	unset test_config
	test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${config}=y" ] ; then
		echo "sed -i -e 's:${config}=y:${config}=m:g' ./KERNEL/.config"
	else
		unset test_config
		test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x" ] ; then
			echo "echo ${config}=m >> ./KERNEL/.config"
		fi
	fi
}

check_config () {
	unset test_config
	test_config=$(grep "${config}=" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		echo "echo ${config}=y >> ./KERNEL/.config"
		echo "echo ${config}=m >> ./KERNEL/.config"
	fi
}

check_config_disable () {
	unset test_config
	test_config=$(grep "${config} is not set" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x" ] ; then
		unset test_config
		test_config=$(grep "${config}=y" ${DIR}/patches/defconfig || true)
		if [ "x${test_config}" = "x${config}=y" ] ; then
			echo "sed -i -e 's:${config}=y:# ${config} is not set:g' ./KERNEL/.config"
		else
			echo "sed -i -e 's:${config}=m:# ${config} is not set:g' ./KERNEL/.config"
		fi
	fi
}

check_if_set_then_set_module () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_module
	fi
}

check_if_set_then_set () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_builtin
	fi
}

check_if_set_then_disable () {
	unset test_config
	test_config=$(grep "${if_config}=y" ${DIR}/patches/defconfig || true)
	if [ "x${test_config}" = "x${if_config}=y" ] ; then
		check_config_disable
	fi
}

#
# General setup
#
config="CONFIG_LOCALVERSION_AUTO"
check_config_disable
config="CONFIG_FHANDLE"
check_config_builtin

#
# RCU Subsystem
#
config="CONFIG_CGROUPS"
check_config_builtin

#
# Kernel Performance Events And Counters
#
config="CONFIG_SECCOMP_FILTER"
check_config_builtin

#
# GCOV-based kernel profiling
#
config="CONFIG_MODULE_FORCE_LOAD"
check_config_builtin
config="CONFIG_MODULE_FORCE_UNLOAD"
check_config_builtin
config="CONFIG_MODVERSIONS"
check_config_builtin

#
# CPU Core family selection
#
config="CONFIG_ARCH_MVEBU"
check_config_disable
config="CONFIG_ARCH_BCM"
check_config_disable
config="CONFIG_ARCH_BERLIN"
check_config_disable
config="CONFIG_ARCH_HIGHBANK"
check_config_disable
config="CONFIG_ARCH_HI3xxx"
check_config_disable
config="CONFIG_ARCH_KEYSTONE"
check_config_disable

#
# OMAP Feature Selections
#
config="CONFIG_SOC_DRA7XX"
check_config_builtin
config="CONFIG_ARCH_ROCKCHIP"
check_config_disable
config="CONFIG_ARCH_SOCFPGA"
check_config_disable
config="CONFIG_PLAT_SPEAR"
check_config_disable
config="CONFIG_ARCH_STI"
check_config_disable
config="CONFIG_ARCH_SUNXI"
check_config_disable
config="CONFIG_ARCH_SIRF"
check_config_disable
config="CONFIG_ARCH_TEGRA"
check_config_disable
config="CONFIG_ARCH_U8500"
check_config_disable
config="CONFIG_ARCH_VEXPRESS"
check_config_disable
config="CONFIG_ARCH_VIRT"
check_config_disable
config="CONFIG_ARCH_WM8850"
check_config_disable
config="CONFIG_ARCH_ZYNQ"
check_config_disable

#
# Processor Features
#
config="CONFIG_ARM_ERRATA_430973"
check_config_builtin

#
# Kernel Features
#
config="CONFIG_ZSMALLOC"
check_config_builtin
config="CONFIG_SECCOMP"
check_config_builtin

#
# CPU Frequency scaling
#
config="CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE"
check_config_builtin
config="CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND"
check_config_disable
config="CONFIG_CPU_FREQ_GOV_POWERSAVE"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_USERSPACE"
check_config_builtin
config="CONFIG_CPU_FREQ_GOV_CONSERVATIVE"
check_config_builtin
config="CONFIG_GENERIC_CPUFREQ_CPU0"
check_config_builtin

#
# ARM CPU frequency scaling drivers
#
config="CONFIG_ARM_IMX6Q_CPUFREQ"
check_config_builtin
config="CONFIG_ARM_OMAP2PLUS_CPUFREQ"
check_config_disable

#
# At least one emulation must be selected
#
config="CONFIG_KERNEL_MODE_NEON"
check_config_builtin

#
# Networking options
#
config="CONFIG_IPV6"
check_config_builtin

#
# Generic Driver Options
#
config="CONFIG_FW_LOADER_USER_HELPER"
check_config_disable

#
# Device Tree and Open Firmware support
#
config="CONFIG_ZRAM"
check_config_module
# CONFIG_ZRAM_DEBUG is not set

#
# SPI Protocol Masters
#
config="CONFIG_SPI_SPIDEV"
check_config_builtin

#
# Pin controllers
#
config="CONFIG_DEBUG_GPIO"
check_config_builtin

#
# I2C GPIO expanders:
#
config="CONFIG_GPIO_TWL6040"
check_config_builtin

#
# Native drivers
#
config="CONFIG_CPU_THERMAL"
check_config_builtin
config="CONFIG_IMX_THERMAL"
check_config_builtin

#
# Texas Instruments thermal drivers
#
config="CONFIG_TI_SOC_THERMAL"
check_config_builtin
config="CONFIG_TI_THERMAL"
check_config_builtin
config="CONFIG_OMAP4_THERMAL"
check_config_builtin
config="CONFIG_OMAP5_THERMAL"
check_config_builtin
config="CONFIG_WATCHDOG"
check_config_builtin
config="CONFIG_WATCHDOG_CORE"
check_config_builtin

#
# Watchdog Device Drivers
#
config="CONFIG_OMAP_WATCHDOG"
check_config_builtin
config="CONFIG_TWL4030_WATCHDOG"
check_config_builtin
config="CONFIG_IMX2_WDT"
check_config_builtin

#
# Multifunction device drivers
#
config="CONFIG_MFD_TPS65217"
check_config_builtin
config="CONFIG_TWL6040_CORE"
check_config_builtin
config="CONFIG_REGULATOR_ANATOP"
check_config_builtin
config="CONFIG_REGULATOR_PFUZE100"
check_config_builtin
config="CONFIG_REGULATOR_TI_ABB"
check_config_builtin
config="CONFIG_REGULATOR_TPS65023"
check_config_builtin
config="CONFIG_REGULATOR_TPS6507X"
check_config_builtin
config="CONFIG_REGULATOR_TPS65217"
check_config_builtin

#
# Multimedia core support
##
# Multimedia core support
#

config="CONFIG_MEDIA_CONTROLLER"
check_config_builtin
config="CONFIG_VIDEO_V4L2_SUBDEV_API"
check_config_builtin
config="CONFIG_MEDIA_CONTROLLER"
check_config_builtin
config="CONFIG_VIDEO_V4L2_SUBDEV_API"
check_config_builtin

#
# I2C encoder or helper chips
#
config="CONFIG_DRM_I2C_NXP_TDA998X"
check_config_builtin
config="CONFIG_DRM_OMAP"
check_config_builtin
config="CONFIG_DRM_TILCDC"
check_config_builtin

#
# Frame buffer hardware drivers
#
config="CONFIG_OMAP2_DSS"
check_config_builtin
config="CONFIG_OMAP2_DSS_DPI"
check_config_builtin
config="CONFIG_OMAP2_DSS_VENC"
check_config_builtin
config="CONFIG_OMAP4_DSS_HDMI"
check_config_builtin

#
# OMAP Display Device Drivers (new device model)
#
config="CONFIG_DISPLAY_ENCODER_TFP410"
check_config_builtin
config="CONFIG_DISPLAY_ENCODER_TPD12S015"
check_config_builtin
config="CONFIG_DISPLAY_CONNECTOR_DVI"
check_config_builtin
config="CONFIG_DISPLAY_CONNECTOR_HDMI"
check_config_builtin
config="CONFIG_DISPLAY_CONNECTOR_ANALOG_TV"
check_config_builtin
config="CONFIG_DISPLAY_PANEL_DPI"
check_config_builtin

#
# Console display driver support
#
config="CONFIG_LOGO"
check_config_builtin
config="CONFIG_LOGO_LINUX_MONO"
check_config_builtin
config="CONFIG_LOGO_LINUX_VGA16"
check_config_builtin
config="CONFIG_LOGO_LINUX_CLUT224"
check_config_builtin

#
# Miscellaneous USB options
#
config="CONFIG_USB_OTG"
check_config_builtin

#
# USB Imaging devices
#
config="CONFIG_USB_MUSB_HDRC"
check_config_builtin
config="CONFIG_USB_MUSB_DUAL_ROLE"
check_config_builtin
config="CONFIG_USB_MUSB_OMAP2PLUS"
check_config_module
config="CONFIG_USB_MUSB_DSPS"
check_config_module
config="CONFIG_USB_MUSB_AM335X_CHILD"
check_config_module
config="CONFIG_MUSB_PIO_ONLY"
check_config_builtin

#
# USB Physical Layer drivers
#
config="CONFIG_AM335X_CONTROL_USB"
check_config_builtin
config="CONFIG_AM335X_PHY_USB"
check_config_builtin
config="CONFIG_TWL6030_USB"
check_config_module
config="CONFIG_USB_GADGET"
check_config_builtin
config="CONFIG_MMC_UNSAFE_RESUME"
check_config_builtin

#
# USB Peripheral Controller
#
config="CONFIG_USB_ETH"
check_config_module
config="CONFIG_USB_ETH_RNDIS"
check_config_builtin

#
# LED drivers
#
config="CONFIG_LEDS_GPIO"
check_config_builtin

#
# LED Triggers
#
config="CONFIG_LEDS_TRIGGER_TIMER"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_ONESHOT"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_HEARTBEAT"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_BACKLIGHT"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_CPU"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_GPIO"
check_config_builtin
config="CONFIG_LEDS_TRIGGER_DEFAULT_ON"
check_config_builtin

#
# on-CPU RTC drivers
#
config="CONFIG_RTC_DRV_OMAP"
check_config_builtin
config="CONFIG_RTC_DRV_SNVS"
check_config_builtin

#
# DMA Devices
#
config="CONFIG_TI_CPPI41"
check_config_builtin

#
# Speakup console speech
#
config="CONFIG_STAGING_MEDIA"
check_config_builtin
config="CONFIG_VIDEO_OMAP4"
check_config_builtin

#
# Android
#
config="CONFIG_ANDROID"
check_config_builtin
config="CONFIG_ANDROID_BINDER_IPC"
check_config_builtin
config="CONFIG_ASHMEM"
check_config_builtin
config="CONFIG_ANDROID_LOGGER"
check_config_module
config="CONFIG_ANDROID_TIMED_OUTPUT"
check_config_builtin
config="CONFIG_ANDROID_TIMED_GPIO"
check_config_module
config="CONFIG_ANDROID_LOW_MEMORY_KILLER"
check_config_disable
config="CONFIG_ANDROID_INTF_ALARM_DEV"
check_config_builtin
config="CONFIG_SYNC"
check_config_builtin
config="CONFIG_ION"
check_config_builtin
config="CONFIG_DRM_IMX"
check_config_builtin
config="CONFIG_DRM_IMX_FB_HELPER"
check_config_builtin
config="CONFIG_DRM_IMX_PARALLEL_DISPLAY"
check_config_builtin
config="CONFIG_DRM_IMX_TVE"
check_config_builtin
config="CONFIG_DRM_IMX_LDB"
check_config_builtin
config="CONFIG_DRM_IMX_IPUV3_CORE"
check_config_builtin
config="CONFIG_DRM_IMX_IPUV3"
check_config_builtin
config="CONFIG_DRM_IMX_HDMI"
check_config_builtin

#
# PHY Subsystem
#
config="CONFIG_TWL4030_USB"
check_config_module

#
# File systems
#
config="CONFIG_XFS_FS"
check_config_builtin
config="CONFIG_BTRFS_FS"
check_config_builtin
config="CONFIG_AUTOFS4_FS"
check_config_builtin

#
# DOS/FAT/NT Filesystems
#
config="CONFIG_MSDOS_FS"
check_config_builtin

#
# Pseudo filesystems
#
config="CONFIG_TMPFS_POSIX_ACL"
check_config_builtin
config="CONFIG_TMPFS_XATTR"
check_config_builtin
config="CONFIG_NLS_CODEPAGE_437"
check_config_builtin
config="CONFIG_NLS_ISO8859_1"
check_config_builtin

#
# Debug Lockups and Hangs
#
config="CONFIG_SCHEDSTATS"
check_config_builtin

echo "#Bugs:"
config="CONFIG_DRM_IMX_HDMI"
check_config_disable

#
