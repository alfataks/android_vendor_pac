# Check for target product
ifeq (pac_hws7300u,$(TARGET_PRODUCT))

# Define PA bootanimation size
TARGET_SCREEN_HEIGHT := 1280	
TARGET_SCREEN_WIDTH := 800

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/huawei/hws7300u/proprietary/media/bootanimation.zip:system/media/bootanimation.zip

# Apns-conf
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Inherit device configuration
$(call inherit-product, device/huawei/hws7300u/cm.mk)

# include ParanoidAndroid common configuration
include vendor/pac/config/pac_common.mk

# AOKP device overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common_tablet

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tvdpi

# Override AOSP build properties
PRODUCT_DEVICE := hws7300u
PRODUCT_NAME := pac_hws7300u
PRODUCT_BRAND := Huawei
PRODUCT_MODEL := Huawei MediaPad
PRODUCT_MANUFACTURER := Huawei

# Update local_manifest.xml
GET_PROJECT_RMS := $(shell vendor/pac/tools/removeprojects.py $(PRODUCT_NAME))
GET_PROJECT_ADDS := $(shell vendor/pac/tools/addprojects.py $(PRODUCT_NAME))

endif
