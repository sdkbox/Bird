
-- app.AtlasInfo = app.AtlasInfo or import('.out')
-- app.Utils = app.Utils or import('.Utils')
-- local textureAtlas = cc.Director:getInstance():getTextureCache():addImage("atlas.png")

local Utils = app.Utils

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- -- add background image
    -- display.newSprite("HelloWorld.png")
    --     :move(display.center)
    --     :addTo(self)

    -- -- add HelloWorld label
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx, display.cy + 200)
    --     :addTo(self)
    self:createLayer()
    	:onTouch(handler(self, self.onTouch))
    	:addTo(self)

    sdkbox.PluginGoogleAnalytics:logScreen('MainScene')
end

function MainScene:createLayer()
	local screenSize = cc.Director:getInstance():getVisibleSize()
	local backLayer = Utils.createCommonBackLayer(screenSize)

	-- logo
	local spriteLogo = Utils.createAtlasSprite("title")
	spriteLogo:setPosition(cc.p(screenSize.width / 2, screenSize.height * 2 / 3))
	backLayer:addChild(spriteLogo)

	-- flappy bird
	local spriteBird = Utils.createBird()
	spriteBird:setPosition(cc.p(screenSize.width / 2, screenSize.height / 2 + 25))

	spriteBird:runAction(Utils.createFlyAction(cc.p(spriteBird:getPosition())))

	backLayer:addChild(spriteBird)

	-- rate button
	local rateButton = Utils.createAtlasSprite("button_rate")
	rateButton:setPosition(cc.p(screenSize.width / 2, screenSize.height / 2 - 35))
	backLayer:addChild(rateButton)
	self.rateButton = rateButton

	-- play button
	local playButton = Utils.createAtlasSprite("button_play")
	playButton:setPosition(cc.p(screenSize.width / 4, screenSize.height / 2 - 120))
	backLayer:addChild(playButton, 1000)
	self.playButton = playButton

	-- rank button
	local rankButton = Utils.createAtlasSprite("button_score")
	rankButton:setPosition(cc.p(screenSize.width * 3 / 4, screenSize.height / 2 - 120))
	backLayer:addChild(rankButton, 1000)
	self.rankButton = rankButton

	-- copy right
	-- local spriteCopyright = Utils.createAtlasSprite("brand_copyright")
	-- spriteCopyright:setPosition(cc.p(screenSize.width / 2, screenSize.height / 2 - 170))
	-- backLayer:addChild(spriteCopyright, 1000)

	return backLayer
end

function MainScene:onTouch(event)

	local point = cc.p(event.x, event.y)
	if 'ended' == event.name then
		if Utils.inNode(self.playButton, point) then
			Utils.enterPlayScene()
		elseif Utils.inNode(self.rateButton, point) then
			sdkbox.PluginReview:show(true)
		elseif Utils.inNode(self.rankButton, point) then
			print('click on rank btton')
		else
		end
		return true
	else
		return true
	end

end

return MainScene
