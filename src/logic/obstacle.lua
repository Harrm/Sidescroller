local Obstacle = {}
local Class = require("class")
local Entity = require("logic.entity")



function Obstacle.new(args)
    local width, height = intRand(30, 300), intRand(30, 300)
    local self = Entity.new {box2dtype = MOAIBox2DBody.KINEMATIC, 
                             loc = {x = args.xPos, y =  intRand(-120, 120)}, 
                             size = {width = width, 
                                     height = height}, 
                             filter_mask = 0x2}
    self.width, self.height = width, height
    self.fixture.nonfatal = true
    self.fixture.entity = self
    self.fixture:setFriction(0)
    Obstacle.setTexture(self, "wall")
    return self
end



function Obstacle:setTexture(name)
    Entity.setTexture(self, name)
    local x, y = self.prop:getDims()
    self.prop:setScl(self.width / x, self.height / y, 1)
end




Class.register(Obstacle, Entity)

return Obstacle