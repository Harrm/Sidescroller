local Game = {}
local Class = require("class")
local StateManager = require("states.state_manager")
local GameState = require("states.game_state")
local MenuState = require("states.menu_state")
local ResultState = require("states.result_state")
local OptionsState = require("states.options_state")
local DefinitionsList = require("resource_control.definitions_list")
local PhysicWorld = require("logic.physic_world")
local over = false



function Game.run()
    Game.init()
    StateManager.update()

    local timer = MOAITimer.new()
    timer:setSpan(1/60)
    timer:setMode(MOAITimer.LOOP)
    timer:start()
    
    repeat
        if timer:getTimesExecuted() > 0 then
            StateManager.update(1/60)
            timer:setTime(0)
        end
        coroutine.yield()
        io.flush()
    until not StateManager.haveStates()

    os.exit()
end



function Game.init()
    MOAIUntzSystem.initialize()

    StateManager.init()
    DefinitionsList:init()
    PhysicWorld.init()

    StateManager.registerState("Game", GameState)
    StateManager.registerState("Menu", MenuState)
    StateManager.registerState("Result", ResultState)
    StateManager.registerState("Options", OptionsState)
    StateManager.requestPush("Menu")
end



Class.registerSingleton(Game)

return Game
