
local PlayScene = class("PlayScene", function()
	return display.newScene("PlayScene", {physics=true})
end)

local Utils = app.Utils

function PlayScene:ctor()
	self:onCreate()
end

function PlayScene:onCreate()
	local systemGravity = -900
	self:getPhysicsWorld():setGravity(cc.p(0, systemGravity))

	self:initVariable()
	self:createLayer():addTo(self)

	self:enableNodeEvents()
end

function PlayScene:onEnter()
	sdkbox.PluginGoogleAnalytics:logScreen('PlayScene')
	sdkbox.PluginGoogleAnalytics:logEvent("Scene", "enter", "PlayScene", 0);
end

function PlayScene:onExit()
	sdkbox.PluginGoogleAnalytics:logEvent("Scene", "leave", "PlayScene", 0);
end

function PlayScene:initVariable()

	self.birdX = 90
	self.birdSize = 15
	self.pipeCount = 5
	self.pipeHeight = 320
	self.pipeDistance = 100
	self.landHeight = 112
	self.tapV = 260
	self.systemGravity = -900

	-- vars
	self.PIPE_NEW = 0
	self.PIPE_PASS = 1
	self.gameOver = false
	self.scoreNode = nil
	self.pipes = {}

	-- for score calcs 0 for
	self.pipeState = {}

	self.totalScore = 0

	self.checkFunc = 0
	self.createPipeFunc = 0
	self.birdRotateFunc = 0

	self.gameLayerListener = nil
	self.overLayerListener = nil
	self.spriteBird = nil
end

function PlayScene:createLayer()
    local layerBg, land_1, land_2 = Utils.createCommonBackLayer(display.size)

    local groudNode = cc.Node:create()
    groudNode:setPhysicsBody(cc.PhysicsBody:createEdgeSegment(cc.p(0, self.landHeight), cc.p(288, self.landHeight)))
    groudNode:getPhysicsBody():setContactTestBitmask(1)
    layerBg:addChild(groudNode)

    -- add bird
    local spriteBird = Utils.createBird()
    spriteBird:setPosition(self.birdX, display.height / 2 + 10)
    spriteBird:setPhysicsBody(cc.PhysicsBody:createCircle(self.birdSize))
    spriteBird:getPhysicsBody():setEnabled(false)
    spriteBird:getPhysicsBody():setContactTestBitmask(1)

    spriteBird:runAction(Utils.createFlyAction(cc.p(spriteBird:getPosition())))

    layerBg:addChild(spriteBird, 1000)
    self.spriteBird = spriteBird

    -- add blink white
    local whiteBlinkSprite = Utils.createAtlasSprite("white")
    whiteBlinkSprite:setScale(100)
    whiteBlinkSprite:setOpacity(0)
    layerBg:addChild(whiteBlinkSprite, 2000)

    -- init ready info
    local rNode = nil
    local rTextSprite = nil
    local rImage = nil
    local function initReady()
    	local readyTextSprite = Utils.createAtlasSprite("text_ready")
    	readyTextSprite:setPosition(cc.p(0, 100))

    	local readyImage = Utils.createAtlasSprite("tutorial")

    	local readyNode = cc.Node:create()
    	readyNode:addChild(readyTextSprite)
    	readyNode:addChild(readyImage)

    	readyNode:setPosition(cc.p(display.width / 2, display.height / 2))

    	rNode = readyNode
    	rTextSprite = readyTextSprite
    	rImage = readyImage

    	layerBg:addChild(readyNode)
    end

    local function hideReady()
        spriteBird:stopActionByTag(Utils.flyTag)
    	rTextSprite:runAction(cc.FadeOut:create(0.2))
    	rImage:runAction(cc.FadeOut:create(0.2))
    end

    initReady()

    -- score
    local scoreNode = cc.Node:create()
    local function initScore()
        scoreNode:setPosition(cc.p(display.width / 2, display.height * 4 / 5 + 10))
        layerBg:addChild(scoreNode, 10000)
    end
    self.scoreNode = scoreNode

    local function refreshScore()
        Utils.createSpriteScore(scoreNode, self.totalScore, 1, 1)
    end

    initScore()
    refreshScore()


	local function blinkWhite()
		local fadeIn = cc.FadeIn:create(0.1)
		local fadeOut = cc.FadeOut:create(0.1)
		whiteBlinkSprite:runAction(cc.Sequence:create(fadeIn, fadeOut))
	end

	local function GameOver()
        self.gameOver = true

		cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.hit)

		for i = 1, self.pipeCount do
			self.pipes[i]:stopAllActions()
		end

		land_1:stopAllActions()
		land_2:stopAllActions()

        spriteBird:getPhysicsBody():setVelocity(cc.p(0, 0))

		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.createPipeFunc)
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.checkFunc)

		blinkWhite()
        layerBg:getEventDispatcher():removeEventListener(self.gameLayerListener)

        self:showGameOverLayer()
	end

	-- check hit and calc score
    local function rotateBird()
        local v = self.spriteBird:getPhysicsBody():getVelocity()
        self.spriteBird:setRotation(math.min(math.max(-90, v.y * 0.2 + 60), 30))
    end

	local function checkHit()

        -- check hit
		if spriteBird:getPositionY() < self.landHeight + self.birdSize then
			GameOver()
			return
		end
        -- calc score
        for i=1, self.pipeCount do

            -- check hit
            if math.abs(self.pipes[i]:getPositionX() - self.birdX) < (self.birdSize + 26) then
                -- check down
                if spriteBird:getPositionY() < self.pipes[i]:getPositionY() + self.pipeHeight / 2 + self.birdSize then
                    cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.fall)
                    GameOver()
                    return
                end
                -- check up
                if spriteBird:getPositionY() > self.pipes[i]:getPositionY() + self.pipeHeight / 2 + self.pipeDistance - self.birdSize then
                    cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.fall)
                    GameOver()
                    return
                end
            end

            if self.pipeState[i] == self.PIPE_NEW and self.pipes[i]:getPositionX() < self.birdX then
                self.pipeState[i] = self.PIPE_PASS
                self.totalScore = self.totalScore + 1
                cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.score)
                refreshScore()
                return
            end
        end
	end


	-- listener
    local touchBeginPoint = nil
    local ready = false

    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        -- cclog("onTouchBegan: %0.2f, %0.2f", location.x, location.y)
        touchBeginPoint = {x = location.x, y = location.y}

        if not ready then
        	ready = true
        	hideReady()
        	self:createPipes(layerBg)
        	spriteBird:getPhysicsBody():setEnabled(true)
            spriteBird:getPhysicsBody():setVelocity(cc.p(0, self.tapV))

        	self.checkFunc = cc.Director:getInstance():getScheduler():scheduleScriptFunc(checkHit, 0, false)
            self.birdRotateFunc = cc.Director:getInstance():getScheduler():scheduleScriptFunc(rotateBird, 0, false)
        else
            -- spriteBird:setPosition(cc.p(birdX, spriteBird:getPositionY() + 10))
            spriteBird:getPhysicsBody():setVelocity(cc.p(0, self.tapV))
            -- spriteBird:getPhysicsBody():applyImpulse(cc.p(0, 20000))
            print(spriteBird:getPhysicsBody():getVelocity().y)
        end


        cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.wing)

         -- CCTOUCHBEGAN event must return true
        return true
    end

    self.gameLayerListener = cc.EventListenerTouchOneByOne:create()
    self.gameLayerListener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    layerBg:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.gameLayerListener, layerBg)

    local function onContactBegin(event, contact)
        print("onContactBegin")
        if not self.gameOver then
            self.gameOver = true
            GameOver()
        end
        spriteBird:getPhysicsBody():setEnabled(false)
        spriteBird:stopAllActions()
        spriteBird:setRotation(-90)

        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.birdRotateFunc)
        self.birdRotateFunc = 0
    end

    local contactListener = cc.EventListenerPhysicsContactWithBodies:create(groudNode:getPhysicsBody(), spriteBird:getPhysicsBody())
    contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    layerBg:getEventDispatcher():addEventListenerWithSceneGraphPriority(contactListener, layerBg)

    return layerBg
end

function PlayScene:createPipes(layer)
    local function initPipe()
    	for i = 1, self.pipeCount do
    		local downPipe = Utils.createAtlasSprite("pipe_down")
			local upPipe = Utils.createAtlasSprite("pipe_up")

			downPipe:setPosition(cc.p(0, self.pipeHeight + self.pipeDistance))

			local singlePipe = cc.Node:create()
			singlePipe:addChild(downPipe)
			singlePipe:addChild(upPipe)

			singlePipe:setPosition(cc.p(- display.width * 2, 0))

			layer:addChild(singlePipe, 10)

			self.pipes[i] = singlePipe
            self.pipeState[i] = self.PIPE_PASS
    	end

    end

    local function createPipe()
    	for i = 1, self.pipeCount do
            print(i)
    		if self.pipes[i]:getPositionX() < -100 then
    			local pipeNode = self.pipes[i]
                self.pipeState[i] = self.PIPE_NEW

    			pipeNode:stopAllActions()

    			local randomHeight = math.random(0,3)

    			pipeNode:setPosition(cc.p(display.width * 2, 50 * randomHeight))
    			pipeNode:setTag(randomHeight)

    			local move = cc.MoveTo:create(8, cc.p(- display.width * 2, 50 * randomHeight))
				pipeNode:runAction(move)
				break
    		end
    	end
	end

	initPipe()
	self.createPipeFunc = cc.Director:getInstance():getScheduler():scheduleScriptFunc(createPipe, 1.3, false)
end

function PlayScene:showGameOverLayer()

    local overLayer = cc.Layer:create()
    local actionNode = cc.Node:create()
    overLayer:addChild(actionNode)

    local gameOverLogo = Utils.createAtlasSprite("text_game_over")
    local scorePanel = Utils.createAtlasSprite("score_panel")

    local nowScoreNode = cc.Node:create()
    local bestScoreNode = cc.Node:create()
    local newInfoSprite = Utils.createAtlasSprite("new")

    local playButton = Utils.createAtlasSprite("button_play")
    local rankButton = Utils.createAtlasSprite("button_score")
    local shareButton = Utils.createAtlasSprite("button_share")

    local function initOverItems()
        -- game over
        gameOverLogo:setPosition(cc.p(display.center.x, display.center.y + 100))
        gameOverLogo:setVisible(false)

        overLayer:addChild(gameOverLogo)

        -- score panel
        scorePanel:setPosition(cc.p(display.center.x, display.center.y))
        scorePanel:setVisible(false)

        -- score node
        nowScoreNode:setPosition(cc.p(200, 80))
        scorePanel:addChild(nowScoreNode)

        bestScoreNode:setPosition(cc.p(200, 40))
        scorePanel:addChild(bestScoreNode)

        -- new info
        newInfoSprite:setPosition(cc.p(155, 60))
        newInfoSprite:setVisible(false)
        scorePanel:addChild(newInfoSprite)


        overLayer:addChild(scorePanel)

        --bottom buttons

        -- play button
        playButton:setPosition(cc.p(display.center.x / 2, display.center.y - 120))
        playButton:setVisible(false)

        overLayer:addChild(playButton, 1000)

        -- rank button
        rankButton:setPosition(cc.p(display.width * 3 / 4, display.center.y - 120))
        rankButton:setVisible(false)

        overLayer:addChild(rankButton, 1000)

        -- share button
        shareButton:move(cc.p(display.center.x, display.center.y - 70))
        	:addTo(overLayer)
        	:setVisible(false)
    end

    local function showOverItems()
        local function showGameOverLogo()
            cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.ui)
            self.scoreNode:setVisible(false)

            gameOverLogo:setVisible(true)

            local place = cc.Place:create(cc.p(display.center.x, display.center.y + 120))
            local move1 = cc.MoveTo:create(0.2, cc.p(display.center.x, display.center.y + 96))
            local move2 = cc.MoveTo:create(0.2, cc.p(display.center.x, display.center.y + 100))

            gameOverLogo:runAction(cc.Sequence:create(place, move1, move2))
        end

        local function showScorePanel()
            cc.SimpleAudioEngine:getInstance():playEffect(app.audioPaths.ui)
            scorePanel:setVisible(true)

            local place = cc.Place:create(cc.p(display.center.x, -100))
            local move1 = cc.MoveTo:create(0.1, cc.p(display.center.x, display.center.y))

            scorePanel:runAction(cc.Sequence:create(place, move1))
        end

        local function showNewRecordInfo()
            newInfoSprite:setVisible(true)
        end

        local function showMedal()
            if self.totalScore < 10 then
                return
            end

            local medalStr = "medals_"..(math.max(4 - math.floor(self.totalScore / 10), 0))
            local medalSprite = Utils.createAtlasSprite(medalStr)

            medalSprite:setPosition(cc.p(55, 60))
            scorePanel:addChild(medalSprite)

        end

        local function showScoreNumber()
            --createSpriteScore(nowScoreNode, self.totalScore, 2, 2)
            local savedBestScore = cc.UserDefault:getInstance():getIntegerForKey("bestScore", 0)
            if self.totalScore > savedBestScore then
                savedBestScore = self.totalScore
                -- show new
                showNewRecordInfo()
                -- save score
                cc.UserDefault:getInstance():setIntegerForKey("bestScore", self.totalScore)
            end

            Utils.createSpriteScore(bestScoreNode, savedBestScore, 2, 2)
            Utils.createSpriteScore(nowScoreNode, 0, 2, 2)

            local tmpScore = 0
            local showSingleNumberFunc = 0
            local function showSingleNumber()
                Utils.createSpriteScore(nowScoreNode, tmpScore, 2, 2)
                tmpScore = tmpScore + 1

                if tmpScore > self.totalScore then
                    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(showSingleNumberFunc)
                end
            end

            showSingleNumberFunc = cc.Director:getInstance():getScheduler():scheduleScriptFunc(showSingleNumber, 0.5 / self.totalScore, false)
        end

        local function showBottomButton()
            playButton:setVisible(true)
            rankButton:setVisible(true)
            -- shareButton:setVisible(true)
        end

        local delay1 = cc.DelayTime:create(1)
        local showOverLogoFunc = cc.CallFunc:create(showGameOverLogo)
        local showScorePanelFunc = cc.CallFunc:create(showScorePanel)
        local showMedalFunc = cc.CallFunc:create(showMedal)
        local showScoreNumberFunc = cc.CallFunc:create(showScoreNumber)
        local showBottomButtonFunc = cc.CallFunc:create(showBottomButton)

        local action = cc.Sequence:create(delay1, showOverLogoFunc, delay1, showScorePanelFunc, showMedalFunc,
            showScoreNumberFunc, delay1, showBottomButtonFunc)
        actionNode:runAction(action)

        sdkbox.PluginGoogleAnalytics:logEvent("Score", "game over", "end", self.totalScore)
        sdkbox.PluginSdkboxPlay:submitScore('global', self.totalScore)

        local v = self.totalScore%10
        local achievementName = 'level' .. v
        if v > 0 then
            sdkbox.PluginSdkboxPlay:unlockAchievement(achievementName);
        end

        if app:canShowAd(true) then
	        sdkbox.PluginSdkboxAds:placement("placement-1");
	    end
    end

    initOverItems()
    showOverItems()
    -- listener

    -- self.overLayerListener = cc.EventListenerTouchOneByOne:create()
    -- self.overLayerListener:registerScriptHandler(onCommonMenuLayerTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    -- self.overLayerListener:registerScriptHandler(onCommonMenuLayerTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    -- overLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.overLayerListener, overLayer)

    self.playButton = playButton
    self.rankButton = rankButton
    self.shareButton = shareButton
    overLayer:onTouch(handler(self, self.onGameOverTouch))

    self:addChild(overLayer)

    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.birdRotateFunc)
    self.birdRotateFunc = 0
end

function PlayScene:onGameOverTouch(event)
	local point = cc.p(event.x, event.y)
	if 'ended' == event.name then
		if Utils.inNode(self.playButton, point) then
			Utils.enterPlayScene()
		elseif Utils.inNode(self.rankButton, point) then
            sdkbox.PluginSdkboxPlay:showLeaderboard('global')
		elseif Utils.inNode(self.shareButton, point) then

			local path = ''
			if "android" == device.platform then
				path = "/mnt/sdcard/screenshot.png"
			else
				path = "screenshot.png"
			end
			cc.utils:captureScreen(function(success, file_path )
				local shareInfo = {}
				shareInfo.text = '#Bird Here are my score on Bird'
				shareInfo.title = "Bird"
				if success then
					shareInfo.image = file_path;
				end
				shareInfo.showDialog = false
				shareInfo.platform = sdkbox.SocialPlatform.Platform_Select;
				sdkbox.PluginShare:share(shareInfo)
			end, path)
		else
		end
		return true
	else
		return true
	end
end

return PlayScene
