local SpringObstacle = {}
local Class = require("class")
local Entity = require("logic.entity")



function SpringObstacle.new(args)
    local radius = intRand(20, 80)
    local self = Entity.new {box2dtype = MOAIBox2DBody.KINEMATIC, 
                             loc = {x = args.xPos, y = intRand(-120, 120)}, 
                             shape = "circle",
                             size = {radius = radius}, 
                             filter_mask = 0x1}
    self.fixture:setRestitution(1)

    self.radius = radius
    SpringObstacle.setTexture(self, "spiral")

    self.prop:moveRot(1800, 10, MOAIEaseType.LINEAR)

    return self
end




function SpringObstacle:setTexture(name)
    Entity.setTexture(self, name)
    local x, y = self.prop:getDims()
    self.prop:setScl(self.radius / x * 2, self.radius / y * 2, 1)
end



Class.register(SpringObstacle, Entity)

return SpringObstacle