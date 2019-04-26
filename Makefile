
include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Tweak Prefs
TARGET=iphone:clang:11.2:11.0
include $(THEOS_MAKE_PATH)/aggregate.mk
