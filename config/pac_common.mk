# Vendor hack
#   $1 = vendor name
#   $2 = product name
define vendor-replace
  $(shell mkdir -p vendor/$(1); \
          rm -rf vendor/$(1)/$(2); \
          ln -sf ../$(1)-extra/$(2) vendor/$(1)/$(2))
endef

# use AOSP default sounds
PRODUCT_PROPERTY_OVERRIDES += \
  ro.config.ringtone=Themos.ogg \
  ro.config.notification_sound=Proxima.ogg \
  ro.config.alarm_alert=Cesium.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/pac/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/pac/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/pac/prebuilt/common/bin/50-backupScript.sh:system/addon.d/50-backupScript.sh

# T-Mobile theme engine
include vendor/pa/config/themes_common.mk

# PAC Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/pac/common

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/pac/CHANGELOG.mkdn:system/etc/PAC-CHANGELOG.txt \
    vendor/pac/CONTRIBUTORS.mkdn:system/etc/PAC-CONTRIBUTORS.txt

### AOKP ###
# AOKP Packages
PRODUCT_PACKAGES += \
    PerformanceControl \
    ROMControl \
    PermissionsManager

# AOKP Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pac/overlay/aokp/common

### PARANOID ###
# PARANOID Packages
PRODUCT_PACKAGES += \
    HALO

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

# Allow device family to add overlays and use a same prop.conf
ifneq ($(OVERLAY_TARGET),)
    PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(OVERLAY_TARGET)
    PA_CONF_SOURCE := $(OVERLAY_TARGET)
else
    PA_CONF_SOURCE := $(TARGET_PRODUCT)
endif

# ParanoidAndroid Proprietary
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/apk/ParanoidPreferences.apk:system/app/ParanoidPreferences.apk \
    vendor/pac/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/properties.conf \
    vendor/pac/prebuilt/pa/$(PA_CONF_SOURCE).conf:system/etc/paranoid/backup.conf

BOARD := $(subst pac_,,$(TARGET_PRODUCT))

# Add CM release version
CM_RELEASE := true
CM_BUILD := $(BOARD)

# Add PA release version
PA_VERSION_MAJOR = 3
PA_VERSION_MINOR = 6
PA_VERSION_MAINTENANCE = 8
PA_PREF_REVISION = 1
VERSION := $(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)
PA_VERSION := pa_$(BOARD)-$(VERSION)-$(shell date +%0d%^b%Y-%H%M%S)

# PAC version
PAC_VERSION_MAJOR = milestone
PAC_VERSION_MINOR = 1
PAC_VERSION_MAINTENANCE = release
PAC_VERSION := $(PAC_VERSION_MAJOR).$(PAC_VERSION_MINOR).$(PAC_VERSION_MAINTENANCE)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.pac.version=$(PAC_VERSION) \
    ro.pacrom.version=pac_$(BOARD)_4.2-$(PAC_VERSION)_$(shell date +%Y%m%d-%H%M%S) \
    ro.modversion=$(PA_VERSION) \
    ro.pa.family=$(PA_CONF_SOURCE) \
    ro.pa.version=$(VERSION) \
    ro.papref.revision=$(PA_PREF_REVISION) \
    ro.aokp.version=$(BOARD)_jb-mr1_milestone-2

# Setup OTA with goo.im
PRODUCT_PROPERTY_OVERRIDES += \
    ro.goo.developerid=pacman \
    ro.goo.rom=pacman \
    ro.goo.version=$(shell date +%s)

# ROMStats Properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.pacstats.url=http://stats.pac-rom.com \
    ro.pacstats.name=PAC-man \
    ro.pacstats.version=$(PAC_VERSION) \
    ro.pacstats.tframe=1
