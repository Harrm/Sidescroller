local Player = {}
local Class = require("class")
local Entity = require("logic.entity")
local StateManager = require("states.state_manager")



function Player.new()
    local self = Entity.new{box2dtype = MOAIBox2DBody.DYNAMIC, 
                            loc = {x = 0, y = 0}, 
                            size = {width = 40, height = 60}, 
                            filter_mask = 0x2}

    self.body:setFixedRotation(0, 0)
    Entity.setTexture(self, "player")
    Entity.addAnimation(self, "idle", {startFrame = 1,frameCount = 12,
                                       time = 0.1, mode = MOAITimer.LOOP})
    Entity.addAnimation(self, "run", {startFrame = 29,frameCount = 8,
                                      time = 0.03, mode = MOAITimer.LOOP})
    Entity.addAnimation(self, "jump", {startFrame = 43,frameCount = 11,
                                       time = 0.03, mode = MOAITimer.NORMAL})
    self.animations["jump"]:setListener(MOAIAction.EVENT_STOP, function() self:startAnimation("run") end)
    Entity.startAnimation(self, "run")

    self.fixture:setFriction(0.5)
   -- self.body:setLinearVelocity(0.01, 0)

    return self
end



function Player:update(deltaTime)
    --self.body:setTransform(0, ({self.body:getPosition()})[2])
    Entity.update(self, deltaTime)
end



Class.register(Player, Entity)

return Player