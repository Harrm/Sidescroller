local MenuState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local Class = require("class")
local State = require("states.state")

local alreadyInit = false



function MenuState.new()
    local self = {}
    self.soundtrack = ResourceManager:get("soundtrack")
    self.soundtrack:play()

    self.guiRoot = GuiParser.readFrom("main_menu_ui.json")

    self.guiRoot:getWidget("new_game"):setCallback(function()
                            StateManager.requestPop()
                            StateManager.requestPush("Game")
                            self.soundtrack:stop()
                            end)
    self.guiRoot:getWidget("options"):setCallback(function()
                            StateManager.requestPop()
                            StateManager.requestPush("Options")
                            self.soundtrack:stop()
                            end)
    self.guiRoot:getWidget("exit"):setCallback(function()
                        StateManager.requestClear()
                        self.soundtrack:stop()
                        end)

    self.guiRoot:show()
    return self
end



function MenuState:destroy()
    self.guiRoot:hide()
end



function MenuState:update(deltaTime)
    self.guiRoot:update(deltaTime)
end



Class.register(MenuState, State)

return MenuState
