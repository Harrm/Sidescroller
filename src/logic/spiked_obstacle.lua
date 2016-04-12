local SpikedObstacle = {}
local Class = require("class")
local Entity = require("logic.entity")



function SpikedObstacle.new(args)
    local direction = intRand(0, 2) == 1 and -1 or 1
    local width = intRand(100, 300)
    local self = Entity.new {box2dtype = MOAIBox2DBody.KINEMATIC, 
                             loc = {x = args.xPos, y = direction*200}, 
                             size = {width = width, height = 30}, 
                             filter_mask = 0x2}
    self.width = width
    self.direction = direction
    Entity.setLinearVelocity(self, nil, direction*intRand(10, 80))
    SpikedObstacle.setTexture(self, "spikes")
    return self
end



function SpikedObstacle:setTexture(name)
    Entity.setTexture(self, name)
    local x, y = self.prop:getDims()
    self.prop:setScl(self.width / x, 30 / y * self.direction * -1, 1)
end



function SpikedObstacle:update(deltaTime)
    local vx, vy = self.body:getLinearVelocity()
    if math.abs(self:getPosition().y) > 230 then
        self:setLinearVelocity(nil, -vy)

    elseif math.abs(self:getPosition().y) < 200 then
        self:setLinearVelocity(nil, -vy)
    end
end



Class.register(SpikedObstacle, Entity)

return SpikedObstacle