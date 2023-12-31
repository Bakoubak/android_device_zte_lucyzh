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

PLATDIR := device/zte/lucyzh
TARGET_BOARD := s9863a1h10
BOARDDIR := $(PLATDIR)
PLATCOMM := $(PLATDIR)/common
TARGET_BOARD := s9863a1h10
BOARDDIR := $(PLATDIR)
ROOTDIR := $(BOARDDIR)/rootdir
TARGET_BOARD_PLATFORM := sp9863a

TARGET_GPU_PLATFORM := rogue
#TARGET_GPU_PLATFORM := soft
TARGET_NO_BOOTLOADER := false

USE_XML_AUDIO_POLICY_CONF := 1
SPRD_AUDIO_HIDL_CLIENT_SUPPORT := true
SPRD_AUDIO_HIDL_CLIENT_VERSION := v5
USE_CONFIGURABLE_AUDIO_POLICY := 1
USE_CUSTOM_CONFIGUREABLE_AUDIO_POLICY := true
BUILD_AUDIO_POLICY_CONFIGURATION := phone_configurable
AUDIO_PFW_PATH := $(ROOTDIR)/system/etc/parameter-framework
AUDIO_PFW_EDD_FILES := \
        $(AUDIO_PFW_PATH)/Settings/device_for_input_source.pfw \
        $(AUDIO_PFW_PATH)/Settings/volumes.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_media.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_accessibility.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_dtmf.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_enforced_audible.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_phone.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_sonification.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_sonification_respectful.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_transmitted_through_speaker.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_rerouting.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_fm.pfw \
        $(AUDIO_PFW_PATH)/Settings/device_for_product_strategy_patch.pfw

# graphics
USE_SPRD_HWCOMPOSER  := true

# support gnss hidl
SUPPORT_GNSS_HARDWARE := true

# support location
SUPPORT_LOCATION := enabled

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(PLATCOMM)/DeviceCommon.mk)
$(call inherit-product, $(PLATCOMM)/proprietaries.mk)
$(call inherit-product-if-exists, vendor/sprd/modules/libcamera/libcam_device.mk)
$(call inherit-product-if-exists, vendor/sprd/modules/faceunlock/faceunlock_device.mk)

#add USB vts service
PRODUCT_PACKAGES += \
    android.hardware.usb@1.1-service

# add for sprd super resultion and picture quality feature
PRODUCT_PACKAGES += LowResolutionPowerSaving

BOARD_HAVE_SPRD_WCN_COMBO := sharkl3
BOARD_SPRD_WCN_SOCKET := sipc
$(call inherit-product-if-exists, vendor/zte/lucyzh/modules/wcn/connconfig/device-sprd-wcn.mk)
$(call inherit-product-if-exists, vendor/zte/lucyzh/modules/wlan/wlanconfig/device-sprd-wlan.mk)

DEVICE_MANIFEST_FILE += $(BOARDDIR)/manifest_typec.xml

#enable F2FS for userdata.img
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

#fstab
ifeq (f2fs,$(strip $(BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE)))
  NORMAL_FSTAB_SUFFIX1 := .f2fs
endif
ifeq (true,$(strip $(BOARD_SECURE_BOOT_ENABLE)))
  NORMAL_FSTAB_SUFFIX2 :=
endif
NORMAL_FSTAB_SUFFIX := $(NORMAL_FSTAB_SUFFIX1)$(NORMAL_FSTAB_SUFFIX2)
# For Dynamic partitions feature, fstab install to ramdisk
PRODUCT_COPY_FILES += $(BOARDDIR)/rootdir/root/fstab.s9863a1h10$(NORMAL_FSTAB_SUFFIX):vendor/etc/fstab.s9863a1h10
PRODUCT_COPY_FILES += $(BOARDDIR)/rootdir/root/fstab.ramdisk:$(TARGET_COPY_OUT_RAMDISK)/fstab.s9863a1h10

include vendor/zte/lucyzh/modules/devdrv/input/misc/tcs3430/tcs3430.mk
#PRODUCT_PACKAGES += \
        tcs3430.ko

PRODUCT_COPY_FILES += \
    $(BOARDDIR)/rootdir/root/init.s9863a1h10.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.s9863a1h10.rc \
    $(ROOTDIR)/prodnv/PCBA.conf:$(TARGET_COPY_OUT_VENDOR)/etc/PCBA.conf \
    $(ROOTDIR)/prodnv/BBAT.conf:$(TARGET_COPY_OUT_VENDOR)/etc/BBAT.conf \
    $(ROOTDIR)/system/etc/audio_params/tiny_hw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/tiny_hw.xml \
    $(ROOTDIR)/system/etc/audio_params/codec_pga.xml:$(TARGET_COPY_OUT_VENDOR)/etc/codec_pga.xml \
    $(ROOTDIR)/system/etc/audio_params/audio_hw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_hw.xml \
    $(ROOTDIR)/system/etc/audio_params/audio_para:$(TARGET_COPY_OUT_VENDOR)/etc/audio_para \
    $(ROOTDIR)/system/etc/audio_params/smart_amp_init.bin:$(TARGET_COPY_OUT_VENDOR)/etc/smart_amp_init.bin \
    $(ROOTDIR)/system/etc/audio_params/record_tone_1.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/record_tone_1.pcm \
    $(ROOTDIR)/system/etc/audio_params/record_tone_2.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/record_tone_2.pcm \
    $(ROOTDIR)/system/etc/audio_params/rx_data.pcm:$(TARGET_COPY_OUT_VENDOR)/etc/rx_data.pcm \
    $(ROOTDIR)/root/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    $(ROOTDIR)/root/init.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.s9863a1h10.usb.rc \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    $(BOARDDIR)/log_conf/slog_modem_$(TARGET_BUILD_VARIANT).conf:vendor/etc/slog_modem.conf \
    $(BOARDDIR)/log_conf/slog_modem_cali.conf:vendor/etc/slog_modem_cali.conf \
    $(BOARDDIR)/log_conf/slog_modem_factory.conf:vendor/etc/slog_modem_factory.conf \
    $(BOARDDIR)/log_conf/slog_modem_autotest.conf:vendor/etc/slog_modem_autotest.conf \
    $(BOARDDIR)/log_conf/mlogservice_$(TARGET_BUILD_VARIANT).conf:vendor/etc/mlogservice.conf \
    $(BOARDDIR)/features/otpdata/otpgoldendata.txt:system/etc/otpdata/otpgoldendata.txt \
    $(BOARDDIR)/features/otpdata/input_parameters_values.txt:system/etc/otpdata/input_parameters_values.txt \
    $(BOARDDIR)/features/otpdata/spw_input_parameters_values.txt:system/etc/otpdata/spw_input_parameters_values.txt \
    $(BOARDDIR)/features/otpdata/obj_disc.txt:system/etc/otpdata/obj_disc.txt \
    $(BOARDDIR)/features/otpdata/sell_aft_cali.txt:system/etc/otpdata/sell_aft_cali.txt \
    $(BOARDDIR)/features/otpdata/sale_after_input_parameters_values.txt:system/etc/otpdata/sale_after_input_parameters_values.txt \
    $(ROOTDIR)/system/vendor/firmware/focaltech-FT5x46.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/focaltech-FT5x46.bin
    $(ROOTDIR)/system/vendor/firmware/EXEC_CALIBRATE_MAG_IMAGE:$(TARGET_COPY_OUT_VENDOR)/firmware/EXEC_CALIBRATE_MAG_IMAGE
    $(ROOTDIR)/system/vendor/firmware/Syna_firmware_HXD.img:$(TARGET_COPY_OUT_VENDOR)/firmware/Syna_firmware_HXD.img
    $(ROOTDIR)/system/vendor/firmware/Syna_firmware_LCE.img:$(TARGET_COPY_OUT_VENDOR)/firmware/Syna_firmware_LCE.img

#copy audio policy config
ifeq ($(USE_XML_AUDIO_POLICY_CONF), 1)
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_configuration_generic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_configuration_smart_pa.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_smart_pa.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/primary_audio_policy_configuration_smart_pa.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration_smart_pa.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(ROOTDIR)/system/etc/audio_policy_config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml
else
PRODUCT_COPY_FILES += \
    $(ROOTDIR)/system/etc/audio_params/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf
endif

#mag sensor cali
PRODUCT_COPY_FILES += \
    vendor/lucyzh/modules/sensors/libsensorhub/ConfigSensor/calibration/mag_cali/akm_cali_img.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/EXEC_CALIBRATE_MAG_IMAGE


#camera sensor config
PRODUCT_COPY_FILES += \
    $(BOARDDIR)/camera/sensor_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sensor_config.xml


# config sepolicy
#duplicate definition
#BOARD_SEPOLICY_DIRS += device/sprd/sharkl3/common/sepolicy \
#    build/target/board/generic/sepolicy

SPRD_GNSS_ARCH := arm64
# GNSS
ifeq ($(strip $(SUPPORT_GNSS_HARDWARE)), true)
SPRD_GNSS_SHARKLE_PIKL2 := true
$(call inherit-product, vendor/zte/lucyzh/modules/wcn/gnss/device-sprd-gps.mk)
endif

#WCN config
#add for wcn kernel defconfig
#BOARD_WCN_CONFIG := built-in
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.modem.wcn.enable=1 \
    ro.vendor.modem.wcn.diag=/dev/slog_wcn0 \
    ro.vendor.modem.wcn.id=1 \
    ro.vendor.modem.wcn.count=1 \
    ro.vendor.modem.gnss.diag=/dev/slog_gnss \
    ro.vendor.wcn.gpschip=ge2

#Display/Graphic config
PRODUCT_PROPERTY_OVERRIDES += \
      ro.sf.lcd_density=480 \
      ro.sf.lcd_width=54 \
      ro.sf.lcd_height=96 \
      ro.opengles.version=196610

# Dual-sim config
PRODUCT_PACKAGES += \
        Stk1 \
        MsmsStk

# enable dual camera calibration
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.camera.dualcamera_cali_enable=1
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.camera.dualcamera_cali_time=3

# config video engine for VOLTE video call
VOLTE_SERVICE_ENABLE := true
ifeq ($(strip $(VOLTE_SERVICE_ENABLE)), true)
PRODUCT_PROPERTY_OVERRIDES += persist.sys.vilte.socket=ap
endif

# sprd hw module
PRODUCT_PACKAGES += \
	lights.$(TARGET_BOARD_PLATFORM) \
	sensors.$(TARGET_BOARD_PLATFORM) \
	camera.$(TARGET_BOARD_PLATFORM) \
	gsp.$(TARGET_BOARD_PLATFORM) \
	dpu.$(TARGET_BOARD_PLATFORM) \
	tinymix \
	audio.primary.$(TARGET_BOARD_PLATFORM) \
        libaudionpi \
        libaudioparamteser \
        parameter-framework.policy \
#	audio_hardware_test \
#	power.$(TARGET_BOARD_PLATFORM) \
	memtrack.$(TARGET_BOARD_PLATFORM)

# dpu enhance module
PRODUCT_PACKAGES += \
	enhance.$(TARGET_BOARD_PLATFORM) \
	enhance_test

PRODUCT_PACKAGES += memtrack.$(TARGET_BOARD_PLATFORM)

#audio vbc_eq
PRODUCT_PACKAGES += audio_vbc_eq \
                    libaudionpi \
                    libaudioparamteser 

#SANSA|SPRD|NONE
PRODUCT_HOST_PACKAGES += imgheaderinsert \
                         packimage.sh

PRODUCT_PACKAGES += iwnpi \
                    libiwnpi \
                    libwifieut \
                    wifi_mac_gen \

#app stats collect
PRODUCT_PROPERTY_OVERRIDES += persist.sys.pwctl.appstats=1
PRODUCT_PACKAGES += \
        AppStatsService

# config sensor features supported by this board
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

#watermark, copy files to /vendor/logo/
PRODUCT_COPY_FILES += \
    $(BOARDDIR)/features/watermark/logo_1200x240.rgba:/vendor/logo/logo_1200x240.rgba \
    $(BOARDDIR)/features/watermark/logo_1000x200.rgba:/vendor/logo/logo_1000x200.rgba \
    $(BOARDDIR)/features/watermark/logo_800x160.rgba:/vendor/logo/logo_800x160.rgba \
    $(BOARDDIR)/features/watermark/time.yuv:/vendor/logo/time.yuv

