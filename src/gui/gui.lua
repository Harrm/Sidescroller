local GUI = {}

local viewport
local layers = {}

local callbacks = {mouse_click = {}, right_mouse_click = {}, keyboard = {}}


function GUI.openWindow(title, width, height)
	  MOAISim.openWindow(title, width, height)
  	viewport = MOAIViewport.new()
  	viewport:setSize(width, height)
  	viewport:setScale(width, height)

  	local layers_names = {"gui", "background", "main"}
    for _, v in pairs(layers_names) do
        layers[v] = MOAILayer2D.new()
        layers[v]:setViewport(viewport)
    end

    MOAIInputMgr.device.mouseLeft:setCallback(function(isPressed) 
                                                   for _, callback in pairs(callbacks.mouse_click) do
                                                       callback(isPressed)
                                                   end
                                               end)
    MOAIInputMgr.device.mouseRight:setCallback(function(isPressed) 
                                                   for _, callback in pairs(callbacks.right_mouse_click) do
                                                       callback(isPressed)
                                                   end
                                               end)
    MOAIInputMgr.device.keyboard:setCallback(function(key, isPressed) 
                                                 for _, callback in pairs(callbacks.keyboard) do
                                                     callback(key, isPressed)
                                                 end 
                                             end)
	  local renderTable = { layers.main, layers.background, layers.gui }
	  MOAIRenderMgr.setRenderTable(renderTable)
end




function GUI.addKeyboardCallback(callback)
    table.insert(callbacks.keyboard, callback)
end



function GUI.addMouseClickCallback(callback)
    table.insert(callbacks.mouse_click, callback)
end



function GUI.addRightMouseClickCallback(callback)
    table.insert(callbacks.right_mouse_click, callback)
end



function GUI.getLayer(id)
    if id == nil then error("id expected") end
    return layers[id]
end



function GUI.getViewport()
    return viewport
end



return GUI
