local Widget = {}

local Class = require("class")



function Widget.new()
    error("Widget is abstract class")
end



function Widget:destroy()
    error("You must impliment the 'destroy' method")
end



function Widget:update(deltaTime)
end



function Widget:onKeyboardEvent(key, isPressed)

end



function Widget:onLeftMouseEvent(isPressed)
end



function Widget:onRightMouseEvent(isPressed)
end



Class.register(Widget)

return Widget