local Entity = {}
local Class = require("class")
local PhysicWorld = require("logic.physic_world")
local ResourceManager = require("resource_control.resource_manager")
local GUI = require("gui.gui")



function Entity.new(args)
    local self = {}
    if type(args.size) ~= "table" or 
       (args.size.radius == nil and (args.size.width == nil or args.size.height == nil)) then
        error("You must specify size(table {width = X, height = Y}")
    end

    self.body = PhysicWorld.addBody(args.box2dtype or MOAIBox2DBody.STATIC, args.loc)

    if args.shape == nil or args.shape == "rect" then
        self.fixture = self.body:addRect(-args.size.width/2, -args.size.height/2, 
                                          args.size.width/2,  args.size.height/2)
    elseif args.shape == "circle" then
        self.fixture = self.body:addCircle(0, 0, args.size.radius)
    end
    --self.fixture:setDensity(1)
    self.fixture:setFriction(0.1)
    self.fixture:setFilter(args.filter_mask or 0)

    self.body:resetMassData()

    self.prop = MOAIProp2D.new()
    self.currentAnimation = 'undef'

    self.layer = "main"

    self.destroyed = false

    return self
end



function Entity:setTexture(name)
    self.prop:setDeck(ResourceManager:get(name))
    self.prop:setParent(self.body)
    self.remapper = MOAIDeckRemapper.new()
    self.remapper:reserve(1)
    self.prop:setRemapper(self.remapper)
    self.animations = {}
    GUI.getLayer(self.layer):insertProp(self.prop)
end



function Entity:addAnimation(name, def)
    local curve = MOAIAnimCurve.new()
    curve:reserveKeys(2)
    curve:setKey(1, 0, def.startFrame, MOAIEaseType.LINEAR)
    curve:setKey(2, def.time * def.frameCount, 
                 def.startFrame + def.frameCount, MOAIEaseType.LINEAR)
    local anim = MOAIAnim:new()
    anim:reserveLinks(1)
    anim:setLink(1, curve, self.remapper, 1)
    anim:setMode(def.mode)
    self.animations[name] = anim
end



function Entity:startAnimation(name)
    if self.currentAnimation ~= "undef" then self.currentAnimation:stop() end
    self.currentAnimation = self.animations[name]
    self.currentAnimation:start()
end



function Entity:destroy()
    if self.prop then GUI.getLayer(self.layer):removeProp(self.prop) end
    self.body:destroy()
    self.fixture:destroy()
    self.destroyed = true
end



function Entity:setAwake(isAwake)
    self.body:setAwake(isAwake)
end



function Entity:getPosition()
    local x, y = self.body:getPosition()
    return {x=x, y=y}
end



function Entity:setLinearVelocity(x, y)
    local vx, vy = self.body:getLinearVelocity()
    self.body:setLinearVelocity(x or vx, 
                                y or vy)
end



function Entity:update(deltaTime)
end



Class.register(Entity)

return Entity