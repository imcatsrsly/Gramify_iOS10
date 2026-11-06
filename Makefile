ARCHS = armv7
TARGET = iphone:clang:10.2:8.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = GramifyReskin
GramifyReskin_FILES = Tweak.xm
GramifyReskin_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Shutter"
