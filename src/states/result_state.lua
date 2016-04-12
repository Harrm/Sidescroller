local ResultState = {}
local ResourceManager = require("resource_control.resource_manager")
local StateManager = require("states.state_manager")
local GuiParser = require("resource_control.data_parsers.gui_parser")
local Class = require("class")
local State = require("states.state")

local alreadyInit = false



function ResultState.new(args)
    local self = {}
    --self.soundtrack = ResourceManager:get("soundtrack")
    --self:playOrStopMusic()

    self.guiRoot = GuiParser.readFrom("result_menu_ui.json")
    self.guiRoot:getWidget("result_text"):setText(args.result_text)

    self.guiRoot:getWidget("new_game"):setCallback(function()
                            StateManager.requestPop()
                            StateManager.requestPush("Game")
                            --self:playOrStopMusic()
                            end)
    self.guiRoot:getWidget("to_menu"):setCallback(function()
                            StateManager.requestPop()
                            StateManager.requestPush("Menu")
                            --self:playOrStopMusic()
                            end)
    self.guiRoot:getWidget("exit"):setCallback(function()
                        StateManager.requestClear()
                        --self:playOrStopMusic()
                        end)

    self.guiRoot:show()
    return self
end



function ResultState:destroy()
    self.guiRoot:hide()
end



function ResultState:update(deltaTime)
    self.guiRoot:update(deltaTime)
end



function ResultState:playOrStopMusic()
    if self.soundtrack:isPlaying() then
        self.soundtrack:stop()
    else
        self.soundtrack:play()
    end
end



Class.register(ResultState, State)

return ResultState
