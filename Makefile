export TARGET = iphone:clang:16.4:14.0
export ARCHS = arm64

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
#uYouLocalization $(TWEAK_NAME)_INJECT_DYLIBS = Tweaks/uYou/Library/MobileSubstrate/DynamicLibraries/uYou.dylib $(THEOS_OBJ_DIR)/uYouLocalization.dylib
$(TWEAK_NAME)_INJECT_DYLIBS = Tweaks/uYou/Library/MobileSubstrate/DynamicLibraries/uYou.dylib $(THEOS_OBJ_DIR)/libFLEX.dylib $(THEOS_OBJ_DIR)/iSponsorBlock.dylib $(THEOS_OBJ_DIR)/YouPiP.dylib $(THEOS_OBJ_DIR)/YouTubeDislikesReturn.dylib $(THEOS_OBJ_DIR)/YTABConfig.dylib $(THEOS_OBJ_DIR)/YTUHD.dylib $(THEOS_OBJ_DIR)/DontEatMyContent.dylib .theos/obj/YTHoldForSpeed.dylib $(THEOS_OBJ_DIR)/YTNoCommunityPosts.dylib $(THEOS_OBJ_DIR)/YTVideoOverlay.dylib $(THEOS_OBJ_DIR)/YouMute.dylib $(THEOS_OBJ_DIR)/YouQuality.dylib .theos/obj/YouGroupSettings.dylib $(THEOS_OBJ_DIR)/YoutubeSpeed.dylib # $(THEOS_OBJ_DIR)/MrBeastify-ObjC.dylib
$(TWEAK_NAME)_EMBED_LIBRARIES = $(THEOS_OBJ_DIR)/libcolorpicker.dylib
$(TWEAK_NAME)_EMBED_FRAMEWORKS = $(_THEOS_LOCAL_DATA_DIR)/$(THEOS_OBJ_DIR_NAME)/install_Alderis.xcarchive/Products/var/jb/Library/Frameworks/Alderis.framework
$(TWEAK_NAME)_EMBED_BUNDLES = $(wildcard Bundles/*.bundle)
$(TWEAK_NAME)_EMBED_EXTENSIONS = $(wildcard Extensions/*.appex)

ifndef YTM_VERSION
YTM_VERSION = 2.0.6
endif
PACKAGE_VERSION_YTM = $(YTM_VERSION)

INSTALL_TARGET_PROCESSES_YTM = YouTubeMusic
TWEAK_NAME_YTM = YTMusicUltimate

$(TWEAK_NAME_YTM)_FILES = $(shell find Source -name '*.xm' -o -name '*.x' -o -name '*.m')
$(TWEAK_NAME_YTM)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DTWEAK_VERSION=$(PACKAGE_VERSION_YTM)
$(TWEAK_NAME_YTM)_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox
$(TWEAK_NAME_YTM)_OBJ_FILES = $(shell find Source/Utils/lib -name '*.a')
$(TWEAK_NAME_YTM)_LIBRARIES = bz2 c++ iconv z
ifeq ($(SIDELOADING),1)
$(TWEAK_NAME_YTM)_FILES += Sideloading.xm
endif

include $(THEOS_MAKE_PATH)/tweak.mk

package:
	@echo "Creating package..."
	# Add commands to create the package here

REMOVE_EXTENSIONS = 1
CODESIGN_IPA = 0

UYOU_PATH = Tweaks/uYou
UYOU_DEB = $(UYOU_PATH)/com.miro.uyou_$(UYOU_VERSION)_iphoneos-arm.deb
UYOU_DYLIB = $(UYOU_PATH)/Library/MobileSubstrate/DynamicLibraries/uYou.dylib
UYOU_BUNDLE = $(UYOU_PATH)/Library/Application\ Support/uYouBundle.bundle

internal-clean::
	@rm -rf $(UYOU_PATH)/*

ifeq ($(JAILBROKEN),1)
before-package::
	@mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support; cp -r Localizations/uYouPlus.bundle $(THEOS_STAGING_DIR)/Library/Application\ Support/
endif

ifeq ($(ROOTLESS),1)
THEOS_PACKAGE_SCHEME=rootless
endif

ARCHS = arm64
INSTALL_TARGET_PROCESSES = YouTubeMusic
TARGET = iphone:clang:latest:13.0
PACKAGE_VERSION = 2.0.6

THEOS_DEVICE_IP = 192.168.1.9
THEOS_DEVICE_PORT = 22

TWEAK_NAME = YTMusicUltimate

$(TWEAK_NAME)_FILES = $(shell find Source -name '*.xm' -o -name '*.x' -o -name '*.m')
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -DTWEAK_VERSION=$(PACKAGE_VERSION)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation AVFoundation AVKit Photos Accelerate CoreMotion GameController VideoToolbox
$(TWEAK_NAME)_OBJ_FILES = $(shell find Source/Utils/lib -name '*.a')
$(TWEAK_NAME)_LIBRARIES = bz2 c++ iconv z
ifeq ($(SIDELOADING),1)
$(TWEAK_NAME)_FILES += Sideloading.xm
endif

include makefiles/tweak.mk
