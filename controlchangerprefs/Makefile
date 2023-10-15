TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = controlchangerprefs

controlchangerprefs_FILES = CCPRootListController.m
controlchangerprefs_FRAMEWORKS = UIKit
controlchangerprefs_PRIVATE_FRAMEWORKS = Preferences
controlchangerprefs_INSTALL_PATH = /Library/PreferenceBundles
controlchangerprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
