#include "PluginSdkboxAdsLua.hpp"
#include "PluginSdkboxAds/PluginSdkboxAds.h"
#include "SDKBoxLuaHelper.h"
#include "sdkbox/Sdkbox.h"



int lua_PluginSdkboxAdsLua_PluginSdkboxAds_hideAd(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginSdkboxAds",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        std::string arg0;
        std::string arg1;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "sdkbox.PluginSdkboxAds:hideAd");
        ok &= luaval_to_std_string(tolua_S, 3,&arg1, "sdkbox.PluginSdkboxAds:hideAd");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_hideAd'", nullptr);
            return 0;
        }
        sdkbox::PluginSdkboxAds::hideAd(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginSdkboxAds:hideAd",argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_hideAd'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginSdkboxAdsLua_PluginSdkboxAds_hide(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginSdkboxAds",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "sdkbox.PluginSdkboxAds:hide");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_hide'", nullptr);
            return 0;
        }
        sdkbox::PluginSdkboxAds::hide(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginSdkboxAds:hide",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_hide'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginSdkboxAdsLua_PluginSdkboxAds_placement(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginSdkboxAds",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "sdkbox.PluginSdkboxAds:placement");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_placement'", nullptr);
            return 0;
        }
        sdkbox::PluginSdkboxAds::placement(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginSdkboxAds:placement",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_placement'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginSdkboxAdsLua_PluginSdkboxAds_init(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginSdkboxAds",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_init'", nullptr);
            return 0;
        }
        sdkbox::PluginSdkboxAds::init();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginSdkboxAds:init",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_init'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginSdkboxAdsLua_PluginSdkboxAds_isAvailable(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginSdkboxAds",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "sdkbox.PluginSdkboxAds:isAvailable");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_isAvailable'", nullptr);
            return 0;
        }
        bool ret = sdkbox::PluginSdkboxAds::isAvailable(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginSdkboxAds:isAvailable",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginSdkboxAdsLua_PluginSdkboxAds_isAvailable'.",&tolua_err);
#endif
    return 0;
}
static int lua_PluginSdkboxAdsLua_PluginSdkboxAds_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (PluginSdkboxAds)");
    return 0;
}

int lua_register_PluginSdkboxAdsLua_PluginSdkboxAds(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"sdkbox.PluginSdkboxAds");
    tolua_cclass(tolua_S,"PluginSdkboxAds","sdkbox.PluginSdkboxAds","",nullptr);

    tolua_beginmodule(tolua_S,"PluginSdkboxAds");
        tolua_function(tolua_S,"hideAd", lua_PluginSdkboxAdsLua_PluginSdkboxAds_hideAd);
        tolua_function(tolua_S,"hide", lua_PluginSdkboxAdsLua_PluginSdkboxAds_hide);
        tolua_function(tolua_S,"placement", lua_PluginSdkboxAdsLua_PluginSdkboxAds_placement);
        tolua_function(tolua_S,"init", lua_PluginSdkboxAdsLua_PluginSdkboxAds_init);
        tolua_function(tolua_S,"isAvailable", lua_PluginSdkboxAdsLua_PluginSdkboxAds_isAvailable);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(sdkbox::PluginSdkboxAds).name();
    g_luaType[typeName] = "sdkbox.PluginSdkboxAds";
    g_typeCast["PluginSdkboxAds"] = "sdkbox.PluginSdkboxAds";
    return 1;
}
TOLUA_API int register_all_PluginSdkboxAdsLua(lua_State* tolua_S)
{
	tolua_open(tolua_S);

	std::stringstream ss("sdkbox");
    std::vector<std::string> nsvec;
    std::string item;
    while (std::getline(ss, item, '.')) {
        nsvec.push_back(item);
    }
    int nsLen = nsvec.size();
    item = nsvec.front();
    nsvec.erase(nsvec.begin());

    tolua_module(tolua_S, item.c_str(), 0);
    tolua_beginmodule(tolua_S, item.c_str());

    while (nsvec.size() > 0) {
        item = nsvec.front();
        nsvec.erase(nsvec.begin());
        lua_pushstring(tolua_S, item.c_str()); // m name
        lua_rawget(tolua_S, -2);             // m value
        if (!lua_istable(tolua_S, -1)) {
            lua_pop(tolua_S, 1);             // m
            lua_newtable(tolua_S);           // m t
            lua_pushstring(tolua_S, item.c_str()); // m t name
            lua_pushvalue(tolua_S, -2);      // m t name t
            lua_rawset(tolua_S, -4);         // m t
        }
    }

	lua_register_PluginSdkboxAdsLua_PluginSdkboxAds(tolua_S);

	if (nsLen > 1) {
        lua_pop(tolua_S, nsLen - 1); // m
    }
	tolua_endmodule(tolua_S);

	sdkbox::setProjectType("lua");
	return 1;
}

