# Variables
TARGET = iphone:clang:16.4:14.0
ARCHS = arm64

export libcolorpicker_ARCHS = arm64
export libFLEX_ARCHS = arm64
export Alderis_XCODEOPTS = LD_DYLIB_INSTALL_NAME=@rpath/Alderis.framework/Alderis
export Alderis_XCODEFLAGS = DYLIB_INSTALL_NAME_BASE=/Library/Frameworks BUILD_LIBRARY_FOR_DISTRIBUTION=YES ARCHS="$(ARCHS)"
export libcolorpicker_LDFLAGS = -F$(TARGET_PRIVATE_FRAMEWORK_PATH) -install_name @rpath/libcolorpicker.dylib
export ADDITIONAL_CFLAGS = -I$(THEOS_PROJECT_DIR)/Tweaks/RemoteLog

ifndef YOUTUBE_VERSION
YOUTUBE_VERSION = 19.13.1
endif
ifndef UYOU_VERSION
UYOU_VERSION = 3.0.3
endif
PACKAGE_VERSION = $(YOUTUBE_VERSION)-$(UYOU_VERSION)

INSTALL_TARGET_PROCESSES = YouTube
TWEAK_NAME = uYouEnhanced
DISPLAY_NAME = YouTube
BUNDLE_ID = com.google.ios.youtube

$(TWEAK_NAME)_FILES := $(wildcard Sources/*.xm) $(wildcard Sources/*.x) $(wildcard Sources/*.m)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox Security
$(TWEAK_NAME)_LIBRARIES = bz2 c++ iconv z
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-but-set-variable -DTWEAK_VERSION=\"$(PACKAGE_VERSION)\"
$(TWEAK_NAME)_INJECT_DYLIBS = Tweaks/uYou/Library/MobileSubstrate/DynamicLibraries/uYou.dylib $(THEOS_OBJ_DIR)/libFLEX.dylib $(THEOS_OBJ_DIR)/iSponsorBlock.dylib $(THEOS_OBJ_DIR)/YouPiP.dylib $(THEOS_OBJ_DIR)/YouTubeDislikesReturn.dylib $(THEOS_OBJ_DIR)/YTABConfig.dylib $(THEOS_OBJ_DIR)/YTUHD.dylib $(THEOS_OBJ_DIR)/DontEatMyContent.dylib .theos/obj/YTHoldForSpeed.dylib $(THEOS_OBJ_DIR)/YTNoCommunityPosts.dylib $(THEOS_OBJ_DIR)/YTVideoOverlay.dylib $(THEOS_OBJ_DIR)/YouMute.dylib $(THEOS_OBJ_DIR)/YouQuality.dylib .theos/obj/YouGroupSettings.dylib $(THEOS_OBJ_DIR)/YoutubeSpeed.dylib
$(TWEAK_NAME)_EMBED_LIBRARIES = $(THEOS_OBJ_DIR)/libcolorpicker.dylib
$(TWEAK_NAME)_EMBED_FRAMEWORKS = $(_THEOS_LOCAL_DATA_DIR)/$(THEOS_OBJ_DIR_NAME)/install_Alderis.xcarchive/Products/var/jb/Library/Frameworks/Alderis.framework
$(TWEAK_NAME)_EMBED_BUNDLES = $(wildcard Bundles/*.bundle)
$(TWEAK_NAME)_EMBED_EXTENSIONS = $(wildcard Extensions/*.appex)

# YTMusicUltimate Tweak
TWEAK_NAME_YT = YTMusicUltimate

$(TWEAK_NAME_YT)_FILES = $(shell find Source -name '*.xm' -o -name '*.x' -o -name '*.m')
$(TWEAK_NAME_YT)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DTWEAK_VERSION=$(PACKAGE_VERSION)
$(TWEAK_NAME_YT)_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox
$(TWEAK_NAME_YT)_OBJ_FILES = $(shell find Source/Utils/lib -name '*.a')
$(TWEAK_NAME_YT)_LIBRARIES = bz2 c++ iconv z

# Build targets
all: $(TWEAK_NAME) $(TWEAK_NAME_YT)

$(TWEAK_NAME):
	$(MAKE) package THEOS_DEVICE_IP=192.168.1.9 THEOS_DEVICE_PORT=22

$(TWEAK_NAME_YT):
	$(MAKE) package THEOS_DEVICE_IP=192.168.1.9 THEOS_DEVICE_PORT=22

# Clean target
clean:
	rm -rf $(TWEAK_NAME)_PACKAGE_TMP
	rm -rf $(TWEAK_NAME_YT)_PACKAGE_TMP

.PHONY: all clean $(TWEAK_NAME) $(TWEAK_NAME_YT)
