TARGET := iphone:clang:17.0.2:15.0
INSTALL_TARGET_PROCESSES = SpringBoard

export ARCHS = arm64 arm64e

FINALPACKAGE = 1

THEOS_PACKAGE_SCHEME=rootless

THEOS_DEVICE_IP = 104.38.89.83

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ControlChanger

ControlChanger_FILES = Tweak.x
ControlChanger_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += controlchangerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
