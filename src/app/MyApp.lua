
local CURRENT_MODULE_NAME = ...
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
	cc.exports.app = self
    math.randomseed(os.time())
    self:loadRes()
end

function MyApp:loadRes()
	self.atlasTexture = cc.Director:getInstance():getTextureCache():addImage("atlas.png")
	self.AtlasInfo = import('.views.out', CURRENT_MODULE_NAME)
	self.Utils = import('.views.Utils', CURRENT_MODULE_NAME)
	self.audioPaths = self.Utils.audioPaths()
end

return MyApp
