local OptionsState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local Class = require("class")
local State = require("states.state")
local Settings = require("logic.settings")

local alreadyInit = false



function OptionsState.new()
    local self = {}

    self.guiRoot = GuiParser.readFrom("options_menu_ui.json")

    self.guiRoot:getWidget("speed"):setText(Settings.speed)
    self.guiRoot:getWidget("frequency"):setText(Settings.obstaclesAppearenceFrequency)

    self.guiRoot:getWidget("to_menu"):setCallback(function()
                            print("SETTINGS", self.guiRoot:getWidget("speed"):getText(), self.guiRoot:getWidget("frequency"):getText())
                            io.flush()
                            Settings.speed = self.guiRoot:getWidget("speed"):getText()
                            Settings.obstaclesAppearenceFrequency = self.guiRoot:getWidget("frequency"):getText()
                            StateManager.requestPop()
                            StateManager.requestPush("Menu")
                            end)

    self.guiRoot:show()
    return self
end



function OptionsState:destroy()
    self.guiRoot:hide()
end



function OptionsState:update(deltaTime)
    self.guiRoot:update(deltaTime)
end



Class.register(OptionsState, State)

return OptionsState
