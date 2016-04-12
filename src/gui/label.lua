local Label = {}
local Class = require("class")
local GUI = require("gui.gui")
local Widget = require("gui.widget")



function Label.new(style)
	local self = {}

	self.textbox = MOAITextBox.new()
	self.textbox:setStyle(style or error("Invalid label style"))
	self.textbox:setLoc(0, 0)
	self.textbox:setYFlip(true)
	self.textbox:setAlignment(MOAITextBox.CENTER_JUSTIFY, 
							  MOAITextBox.CENTER_JUSTIFY)


	return self
end



function Label:destroy()
    self:hide()
	self.textbox = nil
end



function Label:show()
	GUI.getLayer("gui"):insertProp(self.textbox)
end



function Label:hide()
	GUI.getLayer("gui"):removeProp(self.textbox)
end



function Label:setText(text)
	self.textbox:setString(tostring(text))
end



function Label:setLoc(x, y)
	self.textbox:setLoc(x, y)
end



function Label:setSize(width, height)
	local xmin, ymin, xmax, ymax = self.textbox:getRect()
	local origin = {x = xmin + (xmax-xmin)/2, 
					y = ymin + (ymax-ymin)/2}
	self.textbox:setRect(origin.x - width/2, origin.y - height/2,
						 origin.x + width/2, origin.y + height /2)
end



function Label:getText()
	return self.textbox:getString()
end



function Label:inside(x, y)
	return self.textbox:inside(x, y)
end



Class.register(Label, Widget)

return Label
