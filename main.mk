# Copyright (C) 2015 ParanoidAndroid Project
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

export VENDOR := cpa

# CrystalPA
ROM_VERSION_MAJOR := 1
ROM_VERSION_MINOR := 0
ROM_VERSION_MAINTENANCE := 0
ROM_VERSION_TAG := CrystalPA_Alpha

# AOSPA
PA_VERSION_MAJOR := 6
PA_VERSION_MINOR := 0
PA_VERSION_MAINTENANCE := 1
PA_VERSION_TAG := AOSPA

# Include versioning information
VERSION := $(ROM_VERSION_TAG).$(ROM_VERSION_MAJOR).$(ROM_VERSION_MINOR).$(ROM_VERSION_MAINTENANCE)
PA_VERSION := $(PA_VERSION_TAG).$(PA_VERSION_MAJOR).$(PA_VERSION_MINOR).$(PA_VERSION_MAINTENANCE)
export ROM_VERSION := $(VERSION)-$(shell date -u +%Y%m%d)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(ROM_VERSION) \
    ro.cpa.version=$(VERSION) \
    ro.pa.version=$(PA_VERSION)

# Override undesired Google defaults
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.com.google.clientidbase=android-google \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.setupwizard.enterprise_mode=1

# Override old AOSP default sounds with newer Google stock ones
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.alarm_alert=Osmium.ogg \
    ro.config.notification_sound=Tethys.ogg \
    ro.config.ringtone=Titania.ogg

# Enable SIP+VoIP
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Include vendor overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/cpa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/cpa/overlay/$(TARGET_PRODUCT)

# Include support for init.d scripts
PRODUCT_COPY_FILES += vendor/cpa/prebuilt/bin/sysinit:system/bin/sysinit

# Include support for userinit
PRODUCT_COPY_FILES += vendor/cpa/prebuilt/etc/init.d/90userinit:system/etc/init.d/90userinit

# Include APN information
PRODUCT_COPY_FILES += vendor/cpa/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Include support for additional filesystems
# TODO: Implement in vold
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Include support for GApps backup
PRODUCT_COPY_FILES += \
    vendor/cpa/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cpa/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cpa/prebuilt/addon.d/50-backuptool.sh:system/addon.d/50-backuptool.sh

# Build Chromium for Snapdragon (PA Browser)
PRODUCT_PACKAGES += PA_Browser

# Build ParanoidHub
PRODUCT_PACKAGES += ParanoidHub

# Include the custom PA bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),480)
     PRODUCT_COPY_FILES += vendor/cpa/prebuilt/bootanimation/480.zip:system/media/bootanimation.zip
endif
ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/cpa/prebuilt/bootanimation/720.zip:system/media/bootanimation.zip
endif
ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/cpa/prebuilt/bootanimation/1080.zip:system/media/bootanimation.zip
endif
ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/cpa/prebuilt/bootanimation/1440.zip:system/media/bootanimation.zip
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Theme engine
PRODUCT_PACKAGES += \
    aapt \
    ThemeChooser \
    ThemesProvider \
    cm.theme.platform-res \
    cm.theme.platform

PRODUCT_COPY_FILES += \
   vendor/cpa/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml

# Include vendor SEPolicy changes
include vendor/cpa/sepolicy/sepolicy.mk

# Include performance tuning if it exists
-include vendor/perf/perf.mk

# Include blur effect if it exists
-include vendor/blur/blur.mk
