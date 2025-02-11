# Check for target product
ifeq (cpa_d855,$(TARGET_PRODUCT))

# Include CPA common configuration
TARGET_BOOT_ANIMATION_RES := 1080
include vendor/cpa/main.mk

$(call inherit-product, device/lge/d855/full_d855.mk)

# Inherit some common Turbo stuff.
#$(call inherit-product, vendor/turbo/config/common_full_phone.mk)

# Enhanced NFC
#$(call inherit-product, vendor/turbo/config/nfc_enhanced.mk)

PRODUCT_NAME := cpa_d855

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE="g3" \
    PRODUCT_NAME="g3_global_com" \
    BUILD_FINGERPRINT="lge/g3_global_com/g3:6.0/MRA58K/15351124649f4:user/release-keys" \
    PRIVATE_BUILD_DESC="g3_global_com-user 6.0 MRA58K 15351124649f4 release-keys"

endif
