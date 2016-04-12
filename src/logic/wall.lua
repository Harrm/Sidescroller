local Wall = {}
local Entity = require("logic.entity")
local Class = require("class")

Wall.Orientation = {Horisontal = 1, Vertical = 2}



function Wall.new(pos, orientation)
    local width, height, xPos, yPos = (orientation == Wall.Orientation.Horisontal)
                                        and 1200, 410, 0, pos
                                        or 1200, 1200, pos, 0

    local self = Entity.new {box2dtype = MOAIBox2DBody.STATIC, 
                               size = {width = width, height = height}, 
                               loc = {x = xPos, y = yPos}, filter_mask = 0x1}
    self.layer = "background"
    Entity.setTexture(self, "wall")
    local x, y = self.prop:getDims()
    self.prop:setScl(width / x, height / y, 1)
    self.fixture:setFriction(0.5)
    return self
end



Class.register(Wall, Entity)

return Wall