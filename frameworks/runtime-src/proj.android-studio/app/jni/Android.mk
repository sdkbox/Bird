LOCAL_PATH := $(call \
my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2dlua_shared

LOCAL_MODULE_FILENAME := libcocos2dlua

LOCAL_SRC_FILES := ../../../Classes/AppDelegate.cpp \
../../../Classes/ide-support/SimpleConfigParser.cpp \
../../../Classes/ide-support/RuntimeLuaImpl.cpp \
../../../Classes/ide-support/lua_debugger.c \
hellolua/main.cpp \
../../../Classes/PluginReviewLua.cpp \
../../../Classes/PluginReviewLuaHelper.cpp \
../../../Classes/SDKBoxLuaHelper.cpp \
../../../Classes/PluginSdkboxPlayLua.cpp \
../../../Classes/PluginSdkboxPlayLuaHelper.cpp \
../../../Classes/PluginSdkboxAdsLua.hpp \
../../../Classes/PluginSdkboxAdsLua.cpp \
../../../Classes/PluginSdkboxAdsLuaHelper.cpp \
../../../Classes/PluginSdkboxAdsLuaHelper.h \
../../../Classes/SDKBoxLuaHelper.h \
../../../Classes/PluginIAPLua.cpp \
../../../Classes/PluginIAPLuaHelper.cpp \
../../../Classes/PluginGoogleAnalyticsLua.hpp \
../../../Classes/PluginGoogleAnalyticsLua.cpp \
../../../Classes/PluginAdColonyLua.cpp \
../../../Classes/PluginAdcolonyLuaHelper.cpp \
../../../Classes/PluginAdMobLua.cpp \
../../../Classes/PluginAdMobLuaHelper.cpp \
../../../Classes/PluginChartboostLua.cpp \
../../../Classes/PluginChartboostLua.hpp \
../../../Classes/PluginChartboostLuaHelper.cpp \
../../../Classes/PluginChartboostLuaHelper.h \
../../../Classes/PluginInMobiLua.cpp \
../../../Classes/PluginInMobiLuaHelper.cpp \
../../../Classes/PluginVungleLua.hpp \
../../../Classes/PluginVungleLua.cpp \
../../../Classes/PluginVungleLuaHelper.cpp \
../../../Classes/PluginVungleLuaHelper.h \
../../../Classes/PluginLeadBoltLua.cpp \
../../../Classes/PluginLeadBoltLuaHelper.cpp \
../../../Classes/PluginAppnextLua.cpp \
../../../Classes/PluginAppnextLuaHelper.cpp \
../../../Classes/PluginFacebookLua.hpp \
../../../Classes/PluginFacebookLua.cpp \
../../../Classes/PluginFacebookLuaHelper.cpp \
../../../Classes/PluginFacebookLuaHelper.h \
../../../Classes/PluginShareLua.cpp \
../../../Classes/PluginShareLuaHelper.cpp

LOCAL_CPPFLAGS := -DSDKBOX_ENABLED
LOCAL_LDLIBS := -landroid \
-llog
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../Classes
LOCAL_WHOLE_STATIC_LIBRARIES := PluginReview \
sdkbox \
PluginSdkboxPlay \
PluginSdkboxAds \
PluginIAP \
android_native_app_glue \
PluginGoogleAnalytics \
PluginAdColony \
PluginAdMob \
PluginChartboost \
PluginInMobi \
PluginVungle \
PluginLeadBolt \
PluginAppnext \
PluginFacebook \
PluginShare

# _COCOS_HEADER_ANDROID_BEGIN
# _COCOS_HEADER_ANDROID_END

LOCAL_STATIC_LIBRARIES := cocos2d_lua_static
LOCAL_STATIC_LIBRARIES += cocos2d_simulator_static

# _COCOS_LIB_ANDROID_BEGIN
# _COCOS_LIB_ANDROID_END

include $(BUILD_SHARED_LIBRARY)
$(call import-add-path,$(LOCAL_PATH))

$(call import-module,scripting/lua-bindings/proj.android)
$(call import-module,tools/simulator/libsimulator/proj.android)
$(call import-module, ./sdkbox)
$(call import-module, ./pluginreview)
$(call import-module, ./pluginsdkboxplay)
$(call import-module, ./pluginsdkboxads)
$(call import-module, ./pluginiap)
$(call import-module, ./plugingoogleanalytics)
$(call import-module, ./pluginadcolony)
$(call import-module, ./pluginadmob)
$(call import-module, ./pluginchartboost)
$(call import-module, ./plugininmobi)
$(call import-module, ./pluginvungle)
$(call import-module, ./pluginleadbolt)
$(call import-module, ./pluginappnext)
$(call import-module, ./pluginfacebook)
$(call import-module, ./pluginshare)

# _COCOS_LIB_IMPORT_ANDROID_BEGIN
# _COCOS_LIB_IMPORT_ANDROID_END
