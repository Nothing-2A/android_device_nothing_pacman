#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nothing/pacman

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := pacman
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x3FFF8000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_TAGS_OFFSET := 0x07C88000
BOARD_RAMDISK_OFFSET := 0x26F08000
BOARD_RAMDISK_USE_LZ4 := true
BOARD_DTB_SIZE := 327372
BOARD_DTB_OFFSET := 0x07C88000
BOARD_KERNEL_BASE := 0x3FFF8000
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INIT_BOOT_HEADER_VERSION := 4

BOARD_KERNEL_CMDLINE += \
    bootopt=64S3,32N2,64N2

BOARD_MKBOOTIMG_ARGS += \
    --base $(BOARD_KERNEL_BASE) \
    --dtb_offset $(BOARD_TAGS_OFFSET) \
    --header_version $(BOARD_BOOT_HEADER_VERSION) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET)

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/$(BOARD_KERNEL_IMAGE_NAME)

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(BOARD_PREBUILT_DTBIMAGE_DIR)/mt6886.dtb

BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor_dlkm.modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor_ramdisk.modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor_ramdisk.modules.load.recovery))
ALL_VENDOR_RAMDISK_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD) $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

BOARD_KERNEL_MODULE_DIR := $(KERNEL_PATH)/modules
BOARD_VENDOR_KERNEL_MODULES := $(addprefix $(BOARD_KERNEL_MODULE_DIR)/,$(BOARD_VENDOR_KERNEL_MODULES_LOAD))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(BOARD_KERNEL_MODULE_DIR)/,$(ALL_VENDOR_RAMDISK_MODULES))

# Platform
TARGET_BOARD_PLATFORM := mt6886
BOARD_HAS_MTK_HARDWARE := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Inherit the proprietary files
include vendor/nothing/pacman/BoardConfigVendor.mk
