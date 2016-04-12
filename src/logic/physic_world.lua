local PhysicWorld = {}
local GUI = require("gui.gui")
local Class = require("class")

local world



function PhysicWorld.init(gravity)
    world = MOAIBox2DWorld.new()
    gravity = gravity or {}
    world:setGravity(gravity.x or 0, gravity.y or -300)
    world:setUnitsToMeters(0.05)
    world:start()
    --GUI.getLayer():setUnderlayTable({world})
end



function PhysicWorld.setGravity(gravity)
    if type(gravity) ~= "table" then 
        error("Gravity vector must be a table")
    end
    world:setGravity(gravity.x or 0, gravity.y or -10)
end



function PhysicWorld.getGravity()
    local x, y = world:getGravity()
    return {x=x, y=y}
end



function PhysicWorld.addBody(body_type, loc)
    if body_type == nil then
        error("You must specify body type")
    end
    local x, y = 0, 0
    if loc ~= nil then
        x, y = loc.x or error("X coordinate is nil"), 
               loc.y or error("Y coordinate is nil")
    end
    return world:addBody(body_type, x, y)
end



function PhysicWorld.start()
    world:start()
end



function PhysicWorld.stop()
    world:stop()
end



Class.registerSingleton(PhysicWorld)

return PhysicWorld