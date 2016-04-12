local MovingObstacle = {}
local Class = require("class")
local Entity = require("logic.entity")



function MovingObstacle.new(args)
    local height = intRand(80, 150)
    local self = Entity.new {box2dtype = MOAIBox2DBody.KINEMATIC, 
                             loc = {x = args.xPos, y =  -30}, 
                             size = {width = 10, height = height}, 
                             filter_mask = 0x2}

    self.height = height
    self.fixture.nonfatal = true
    self.fixture:setFriction(0)
    Entity.setLinearVelocity(self, nil, intRand(200, 400))
    MovingObstacle.setTexture(self, "wall")
    return self
end



function MovingObstacle:setTexture(name)
    Entity.setTexture(self, name)
    self.prop:setRot(90)
    local x, y = self.prop:getDims()
    self.prop:setScl(self.height / x, 10 / y, 1)
end



function MovingObstacle:update(deltaTime)
    local vx, vy = self.body:getLinearVelocity()
    if self:getPosition().y+self.height/2 > 200 then
        self:setLinearVelocity(nil, -vy)
    elseif self:getPosition().y-self.height/2 < -200 then
        self:setLinearVelocity(nil, -vy)
    end
end



Class.register(MovingObstacle, Entity)

return MovingObstacle