#include "PluginReviewLua.hpp"
#include "PluginReview/PluginReview.h"
#include "SDKBoxLuaHelper.h"
#include "sdkbox/Sdkbox.h"



int lua_PluginReviewLua_PluginReview_userDidSignificantEvent(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginReview",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        bool arg0;
        ok &= luaval_to_boolean(tolua_S, 2,&arg0, "sdkbox.PluginReview:userDidSignificantEvent");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_userDidSignificantEvent'", nullptr);
            return 0;
        }
        sdkbox::PluginReview::userDidSignificantEvent(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginReview:userDidSignificantEvent",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginReviewLua_PluginReview_userDidSignificantEvent'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginReviewLua_PluginReview_show(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginReview",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_show'", nullptr);
            return 0;
        }
        sdkbox::PluginReview::show();
        lua_settop(tolua_S, 1);
        return 1;
    }
    if (argc == 1)
    {
        bool arg0;
        ok &= luaval_to_boolean(tolua_S, 2,&arg0, "sdkbox.PluginReview:show");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_show'", nullptr);
            return 0;
        }
        sdkbox::PluginReview::show(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginReview:show",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginReviewLua_PluginReview_show'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginReviewLua_PluginReview_rate(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginReview",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_rate'", nullptr);
            return 0;
        }
        sdkbox::PluginReview::rate();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginReview:rate",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginReviewLua_PluginReview_rate'.",&tolua_err);
#endif
    return 0;
}
int lua_PluginReviewLua_PluginReview_init(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"sdkbox.PluginReview",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_init'", nullptr);
            return 0;
        }
        bool ret = sdkbox::PluginReview::init();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    if (argc == 1)
    {
        const char* arg0;
        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "sdkbox.PluginReview:init"); arg0 = arg0_tmp.c_str();
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_PluginReviewLua_PluginReview_init'", nullptr);
            return 0;
        }
        bool ret = sdkbox::PluginReview::init(arg0);
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "sdkbox.PluginReview:init",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_PluginReviewLua_PluginReview_init'.",&tolua_err);
#endif
    return 0;
}
static int lua_PluginReviewLua_PluginReview_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (PluginReview)");
    return 0;
}

int lua_register_PluginReviewLua_PluginReview(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"sdkbox.PluginReview");
    tolua_cclass(tolua_S,"PluginReview","sdkbox.PluginReview","",nullptr);

    tolua_beginmodule(tolua_S,"PluginReview");
        tolua_function(tolua_S,"userDidSignificantEvent", lua_PluginReviewLua_PluginReview_userDidSignificantEvent);
        tolua_function(tolua_S,"show", lua_PluginReviewLua_PluginReview_show);
        tolua_function(tolua_S,"rate", lua_PluginReviewLua_PluginReview_rate);
        tolua_function(tolua_S,"init", lua_PluginReviewLua_PluginReview_init);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(sdkbox::PluginReview).name();
    g_luaType[typeName] = "sdkbox.PluginReview";
    g_typeCast["PluginReview"] = "sdkbox.PluginReview";
    return 1;
}
TOLUA_API int register_all_PluginReviewLua(lua_State* tolua_S)
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

	lua_register_PluginReviewLua_PluginReview(tolua_S);

	if (nsLen > 1) {
        lua_pop(tolua_S, nsLen - 1); // m
    }
	tolua_endmodule(tolua_S);

	sdkbox::setProjectType("lua");
	return 1;
}

