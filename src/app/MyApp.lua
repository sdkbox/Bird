
local CURRENT_MODULE_NAME = ...
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
	cc.exports.app = self
    math.randomseed(os.time())
    self:loadRes()
    self:initPlugins()
end

function MyApp:loadRes()
	self.removeAdsEnable = cc.UserDefault:getInstance():getBoolForKey("remove_ads", false)

	self.atlasTexture = cc.Director:getInstance():getTextureCache():addImage("atlas.png")
	self.AtlasInfo = import('.views.out', CURRENT_MODULE_NAME)
	self.Utils = import('.views.Utils', CURRENT_MODULE_NAME)
	self.audioPaths = self.Utils.audioPaths()
end

function MyApp:initPlugins()
	sdkbox.PluginReview:setListener(function (event)
	end)
	sdkbox.PluginSdkboxPlay:setListener(function(args)
	    if "onConnectionStatusChanged" == args.name then
	        local status = args.status;

	    elseif "onScoreSubmitted" ==  args.name then
	        local leaderboard_name = args.leaderboard_name;
	        local score= args.score;
	        local maxScoreAllTime= args.maxScoreAllTime;
	        local maxScoreWeek= args.maxScoreWeek;
	        local maxScoreToday= args.maxScoreToday;

	    elseif "onIncrementalAchievementUnlocked" ==  args.name then
	        local achievement_name = args.achievement_name;

	    elseif "onIncrementalAchievementStep" ==  args.name then
	        local achievement_name = args.achievement_name;
	        local step = args.step;

	    elseif "onAchievementUnlocked" ==  args.name then
	        local achievement_name = args.achievement_name;
	        local newlyUnlocked = args.newlyUnlocked;

	    end
	end)
	sdkbox.PluginSdkboxAds:setListener(function(args)
	    if "onAdAction" == args.name then
	        local ad_unit_id = args.ad_unit_id;
	        local ad_name = args.ad_name;
	        local ad_action_type = args.ad_action_type;
	    elseif "onRewardAction" ==  args.name then
	        local ad_unit_id = args.ad_unit_id;
	        local ad_name = args.ad_name;
	        local reward_amount = args.reward_amount;
	        local reward_success = args.reward_success;
	    end
	end)
	sdkbox.IAP:setListener(function(args)
        if "onSuccess" == args.event then
            local product = args.product
            if 'remove_ads' == product.name then
	            cc.UserDefault:getInstance():setBoolForKey("remove_ads", true)
	            self.removeAdsEnable = true
	        else
	        	print('unknown purchase object')
	        end
        elseif "onFailure" == args.event then
                local product = args.product
                local msg = args.msg
                dump(product, "onFailure:")
                print("msg:", msg)
        elseif "onCanceled" == args.event then
                local product = args.product
                dump(product, "onCanceled:")
        elseif "onRestored" == args.event then
                local product = args.product
                dump(product, "onRestored:")
        elseif "onProductRequestSuccess" == args.event then
                local products = args.products
                self.iap_products = products
                -- dump(products, "onProductRequestSuccess:")
        elseif "onProductRequestFailure" == args.event then
                local msg = args.msg
                print("msg:", msg)
        elseif "onInitialized" == args.event then
        	if not args.ok then
        		print('IAP initial fail')
        	end
        else
                print("unknown event ", args.event)
        end
	end)
	-- sdkbox.PluginShare:setListener(function(responsed)
	--     dump(responsed, "PluginShare share listener info:")
	--     if responsed.response.state == sdkbox.SocialShareState.SocialShareStateSuccess then
	--         print('share success')
	--     end

	-- end)
	sdkbox.PluginReview:init()
	sdkbox.PluginSdkboxPlay:init()
	sdkbox.PluginSdkboxAds:init()
	sdkbox.IAP:init()
	sdkbox.PluginGoogleAnalytics:init()
	-- sdkbox.PluginShare:init()

	sdkbox.PluginGoogleAnalytics:startSession()
	sdkbox.PluginSdkboxPlay:signin()
end

function MyApp:canShowAd(incAdUse)
	if self.removeAdsEnable then
		return false
	end

	if nil == self.userAdTimes then
		self.userAdTimes = 0
	end

	local v = self.userAdTimes%7
	if v > 0 then
		print('HHH not show ad userAdTimes:' .. self.userAdTimes)
		return false
	end

	if incAdUse then
		self:incUserAdEvent()
	end

	print('HHH can show ad')
	return true
end

function MyApp:incUserAdEvent()
	if nil == self.userAdTimes then
		self.userAdTimes = 0
	end
	self.userAdTimes = self.userAdTimes + 1
end

function MyApp:purchase(name)
	if self:getIAPProduct(name) then
		sdkbox.IAP:purchase(name)
	else
		print('invalid iap product name')
	end
end

function MyApp:restorePurchase()
	sdkbox.IAP:restore()
end

function MyApp:getIAPProduct(name)
	if nil == self.iap_products then
		return
	end
	for i, p in ipairs(self.iap_products) do
		if p.name == name then
			return p
		end
	end
end

return MyApp
