TARGET_KERNEL_SOURCE := kernel/zte/lucyzh

include device/sprd/sharkl3/s9863a1h10/s9863a1h10_Natv.mk

BOARD_PATH=$(KERNEL_PATH)/sprd-board-config/sharkl3/sp9863a_1h10/s9863a1h10_Tsg
include $(BOARD_PATH)

# Override
PRODUCT_NAME := lineage_lucyzh
TARGET_BOOTLOADER_BOARD_NAME := sp9863a_tsg
#CHIPRAM_DEFCONFIG := sp9863a_tsg
UBOOT_DEFCONFIG := sp9863a_tsg
UBOOT_TARGET_DTB := sp9863a_tsg
TARGET_BOARD_CAMERA_FUNCTION_DUMMY := false
TARGET_SUPPORT_ADF_DISPLAY := false
