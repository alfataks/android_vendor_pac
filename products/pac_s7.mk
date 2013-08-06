# Check for target product
ifeq (pac_s7,$(TARGET_PRODUCT))

# Define PA bootanimation size
TARGET_SCREEN_HEIGHT := 800	
TARGET_SCREEN_WIDTH := 480

# Inherit device configuration
$(call inherit-product, device/huawei/s7/cm.mk)

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common_tablet

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_mdpi

# Override AOSP build properties
PRODUCT_NAME := pac_s7
PRODUCT_DEVICE := s7
PRODUCT_BRAND := HUAWEI
PRODUCT_MODEL := IDEOS S7-10X
PRODUCT_MANUFACTURER := HUAWEI

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=S7_HW_SE TARGET_DEVICE=qsd8k_s7

endif
