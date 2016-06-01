
local CURRENT_MODULE_NAME = ...

local Utils = {}
local atlasInfo = app.AtlasInfo
local atlasTexture = app.atlasTexture

Utils.flySpeed = 2.5
Utils.flyOffset = 5
Utils.flyTag = 1000

function Utils.createCommonBackLayer(screenSize)
    local layerBg = cc.Layer:create()

    local randomBgIndex = math.random(1, 2)
    local bgName = "bg_day"
    if randomBgIndex == 2 then
        bgName = "bg_night"
    end

    local bg = Utils.createAtlasSprite(bgName)
    bg:setPosition(cc.p(screenSize.width / 2, screenSize.height / 2))
    layerBg:addChild(bg)

    local landHeight = Utils.getSpriteSize("land").height

    -- first moving land
    local land_1 = Utils.createAtlasSprite("land")
    land_1:setPosition(screenSize.width / 2, landHeight / 2)
    layerBg:addChild(land_1, 100)

    local move1 = cc.MoveTo:create(2, cc.p(- screenSize.width / 2, landHeight / 2))
    local reset1 = cc.Place:create(cc.p(screenSize.width / 2, landHeight / 2))
    land_1:runAction(cc.RepeatForever:create(cc.Sequence:create(move1, reset1)))

    -- second moving land
    local land_2 = Utils.createAtlasSprite("land")
    land_2:setPosition(screenSize.width * 3 / 2, landHeight / 2)
    layerBg:addChild(land_2, 100)

    local move2 = cc.MoveTo:create(2, cc.p(screenSize.width / 2, landHeight / 2))
    local reset2 = cc.Place:create(cc.p(screenSize.width * 3 / 2, landHeight / 2))
    land_2:runAction(cc.RepeatForever:create(cc.Sequence:create(move2, reset2)))

    return layerBg, land_1, land_2
end

function Utils.createAtlasSprite(name)
    local tmpTable = atlasInfo[name]

    local rectX = tmpTable.x
    local rectY = tmpTable.y
    local rectWidth = tmpTable.width
    local rectHeight = tmpTable.height

    -- fix 1px edge bug
    if name == "land" then
        rectX = rectX + 1
    end

    local rect = cc.rect(rectX, rectY, rectWidth, rectHeight)
    local frame = cc.SpriteFrame:createWithTexture(atlasTexture, rect)
    local atlasSprite = cc.Sprite:createWithSpriteFrame(frame)

    return atlasSprite
end

function Utils.getSpriteSize(name)
    return cc.size(atlasInfo[name].width, atlasInfo[name].height)
end

function Utils.createBird()
    local randomIndex = math.random(0, 2)

    local birdFrames = {}
    for i=1,3 do
        local tmpTable = atlasInfo["bird"..randomIndex.."_"..(i-1)]
        local rect = cc.rect(tmpTable.x, tmpTable.y, tmpTable.width, tmpTable.height)
        local frame = cc.SpriteFrame:createWithTexture(atlasTexture, rect)
        birdFrames[#birdFrames + 1] = frame
    end

    local spriteBird = cc.Sprite:createWithSpriteFrame(birdFrames[1])

    local animation = cc.Animation:createWithSpriteFrames(birdFrames, 0.1)
    local animate = cc.Animate:create(animation);
    spriteBird:runAction(cc.RepeatForever:create(animate))

    return spriteBird
end

function Utils.createFlyAction(position)
    local moveUp   = cc.MoveTo:create(1.0 / Utils.flySpeed, cc.p(position.x, position.y + Utils.flyOffset))
    local moveDown = cc.MoveTo:create(1.0 / Utils.flySpeed, cc.p(position.x, position.y - Utils.flyOffset))

    local flyAction = cc.RepeatForever:create(cc.Sequence:create(moveUp, moveDown))
    flyAction:setTag(Utils.flyTag)
    return flyAction
end

--size : 1.big 2.small
--alignType : 1. mid 2. right
function Utils.createSpriteScore(rootNode, score, size, alignType)
    local function createScoreDigit(digit)
        if size == 1 then
            return Utils.createAtlasSprite("font_0"..(48 + digit))
        end
        return Utils.createAtlasSprite("number_score_0"..digit)
    end

    rootNode:removeAllChildren()

    local distance = 20
    if size == 2 then
        distance = 15
    end

    local digits = {}
    local tmpScore = score
    local dig = math.fmod(tmpScore, 10)
    digits[#digits + 1] = dig
    while math.floor(tmpScore / 10) ~= 0 do
        tmpScore = math.floor(tmpScore / 10)
        dig = math.fmod(tmpScore, 10)
        digits[#digits + 1] = dig
    end

    local nowOffset = (#digits - 1) * distance / 2
    if alignType == 2 then
        nowOffset = 0
    end

    for i=1, #digits do
        local digitSprite = createScoreDigit(digits[i])
        digitSprite:setPosition(cc.p(nowOffset, 0))
        rootNode:addChild(digitSprite)
        nowOffset = nowOffset - distance
    end

end

function Utils.inNode(node, point)
    local nsp = node:convertToNodeSpace(point)
    local rect = node:getBoundingBox()
    rect.x = 0
    rect.y = 0

    if cc.rectContainsPoint(rect, nsp) then
        return true
    end
    return false
end

function Utils.enterPlayScene()
    local playScene = import('.PlayScene', CURRENT_MODULE_NAME)
    display.runScene(playScene.new(), "fade", 0.6, display.COLOR_WHITE)
    -- app:enterScene('PlayScene')
end

function Utils.audioPaths()
    local audioPaths = {}
    audioPaths.wing = cc.FileUtils:getInstance():fullPathForFilename("sfx_wing.wav")
    audioPaths.hit = cc.FileUtils:getInstance():fullPathForFilename("sfx_hit.wav")
    audioPaths.score = cc.FileUtils:getInstance():fullPathForFilename("sfx_point.wav")
    audioPaths.fall = cc.FileUtils:getInstance():fullPathForFilename("sfx_die.wav")
    audioPaths.ui = cc.FileUtils:getInstance():fullPathForFilename("sfx_swooshing.wav")

    return audioPaths
end

return Utils
