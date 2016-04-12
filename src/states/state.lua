local State = {}
local Class = require("class")



function State.new()
    error("State is abstract class")
end



function State:destroy()
    error("You must impliment the 'destroy' method")
end



function State:update(deltaTime)
end



function State:onKeyboardEvent(key, isPressed)
end



Class.register(State)

return State