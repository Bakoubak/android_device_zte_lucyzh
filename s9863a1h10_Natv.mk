#
# Copyright 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
TARGET_KERNEL_SOURCE := kernel/zte/lucyzh
$(call inherit-product, device/zte/lucyzh/s9863a1h10_Base.mk)
PLATDIR := device/zte/lucyzh
PLATCOMM := device/zte/lucyzh/common
ROOTDIR := $(BOARDDIR)/rootdir
TARGET_BOARD_PLATFORM := sp9863a
TARGET_GPU_PLATFORM := rogue

TARGET_BOOTLOADER_BOARD_NAME := sp9863a_1h10
CHIPRAM_DEFCONFIG := sp9863a_1h10
UBOOT_DEFCONFIG := sp9863a_1h10
UBOOT_TARGET_DTB := sp9863a_1h10

PRODUCT_NAME := lineage_lucyzh
PRODUCT_DEVICE := lucyzh
PRODUCT_BRAND := zte
PRODUCT_MODEL := ZTE Blade A5 2019
PRODUCT_WIFI_DEVICE := sprd
PRODUCT_MANUFACTURER := zte

DEVICE_PACKAGE_OVERLAYS := $(BOARDDIR)/overlay $(PLATDIR)/overlay $(PLATCOMM)/overlay

#Runtime Overlay Packages
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a15
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_KERNEL_ARCH = arm64
TARGET_USES_64_BIT_BINDER := true

#add for microarray fingerprint
BOARD_FINGERPRINT_CONFIG := microarray

#secure boot
BOARD_SECBOOT_CONFIG := true

BOARD_TEE_CONFIG := trusty

$(call inherit-product, $(PLATCOMM)/security_feature.mk)

#enable blur & bokeh
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cam.ba.blur.version=6 \
    persist.vendor.cam.fr.blur.version=1
#MMI main menu camera calibration & verification entry: 0-not display, 1-display
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.multicam.cali.veri=1

#enable beauty
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.facebeauty.corp=2

#enable cnr
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.cnr.mode=1

#enable ai
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ai.scence.enable=true

#enable wt
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.wt.enable=0

#enable hdr_zsl
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.hdr.zsl=1

#BOKEH feature
PRODUCT_PROPERTY_OVERRIDES += \
   persist.vendor.cam.res.bokeh=RES_12M
#enable back portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.ba.portrait.enable=0
#enable front portrait mode
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.fr.portrait.enable=0

#enable nightshot pro
# PRODUCT_PROPERTY_OVERRIDES += persist.vendor.cam.night.pro.enable=0

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/s9863a1h10.xml:$(PRODUCT_OUT)/s9863a1h10.xml

PRODUCT_AAPT_CONFIG := normal large xlarge mdpi 420dpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_AAPT_PREBUILT_DPI := 480dpi xxhdpi

#Preset TouchPal InputMethod
PRODUCT_REVISION := oversea multi-lang

#enable VoWiFi
VOWIFI_SERVICE_ENABLE := true

#enable TUI
BOARD_TUI_CONFIG := false

#For Modem build
PRODUCT_MODEM_COPY_LIST :=

# FOR BSP
TARGET_BSP_OUT := bsp/out/lucyzh/dist
TARGET_PREBUILT_KERNEL := $(TARGET_BSP_OUT)/kernel/Image
BSP_DTB_NAME := sp9863a-1h10
TARGET_PREBUILT_DTB := $(TARGET_BSP_OUT)/kernel/$(BSP_DTB_NAME).dtb

PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL):kernel

BOARD_PREBUILT_DTBOIMAGE := $(TARGET_BSP_OUT)/kernel/dtbo.img

# For bsp ko partitions build
PRODUCT_VENDOR_KO_MOUNT_POINT := /mnt/vendor
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.ko.mount.point=$(PRODUCT_VENDOR_KO_MOUNT_POINT)

BSP_KERNEL_MODULES_OUT := $(TARGET_BSP_OUT)/modules

PRODUCT_SOCKO_KO_LIST := \
    $(BSP_KERNEL_MODULES_OUT)/flash_ic_ocp8137.ko \
    $(BSP_KERNEL_MODULES_OUT)/pvrsrvkm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdbt_tty.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_camera.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_cpp.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_flash_drv.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_fm.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprd_sensor.ko \
    $(BSP_KERNEL_MODULES_OUT)/sprdwl_ng.ko \
    $(BSP_KERNEL_MODULES_OUT)/tcs3430.ko \
    $(BSP_KERNEL_MODULES_OUT)/microarray_fp.ko

# Gets ko list by ko dirs and ko names
ifeq ($(strip $(PRODUCT_SOCKO_KO_LIST)),)
PRODUCT_SOCKO_KO_DIRS := \
    $(BSP_KERNEL_MODULES_OUT)

PRODUCT_SOCKO_KO_NAMES :=
endif

PRODUCT_ODMKO_KO_LIST :=

# Gets ko list by ko dirs and ko names
ifeq ($(strip $(PRODUCT_ODMKO_KO_LIST)),)
PRODUCT_ODMKO_KO_DIRS := \
    $(BSP_KERNEL_MODULES_OUT)

PRODUCT_ODMKO_KO_NAMES :=
endif

