local GameState = {}
local GuiParser = require("resource_control.data_parsers.gui_parser")
local StateManager = require("states.state_manager")
local PhysicWorld = require("logic.physic_world")
local Entity = require("logic.entity")
local Scene = require("logic.scene")
local Class = require("class")
local Obstacle = require("logic.obstacle")
local MovingObstacle = require("logic.moving_obstacle")
local SpringObstacle = require("logic.spring_obstacle")
local SpikedObstacle = require("logic.spiked_obstacle")
local State = require("states.state")
local Player = require("logic.player")
local Settings = require("logic.settings")
local ResourceManager = require("resource_control.resource_manager")



local function collide(self, event, thisFixture, thatFixture, arbiter, smth)
    if thatFixture.floor then
        self.player.prop:setScl(1, 1)
    
    elseif thatFixture.ceil then
        self.player.prop:setScl(1, -1)
    
    elseif thatFixture.nonfatal then
        local _, yScl = self.player.prop:getScl()
        local _, vy = self.player.body:getLinearVelocity()
        self.player.prop:setScl(1, vy > 0 and -1 or (vy < 0 and 1 or yScl))
        if self.player.currentAnimation == self.player.animations["jump"] then
            thatFixture.entity:destroy()
        else
            --self:overGame("Defeat")
        end
    else
        self:overGame("Defeat")
    end
end



function GameState.new()
    local self = {}
    self.soundtrack = ResourceManager:get("soundtrack")
    self.soundtrack:play()

    self.guiRoot = GuiParser.readFrom("game_ui.json")
    self.guiRoot:show()

    self.player = Player()
    self.player.fixture:setCollisionHandler(function(...) collide(self, ...) end, 
                                             MOAIBox2DArbiter.BEGIN, 0xFF)

    self.scene = Scene(self.player)
    local lastLoc = 300
    for i = 1, 80 do
        lastLoc = lastLoc + intRand(100 - Settings.obstaclesAppearenceFrequency, 
                                    400  - Settings.obstaclesAppearenceFrequency)
        local obstacleTypes = {Obstacle, MovingObstacle, SpringObstacle, SpikedObstacle}
        local randomType = obstacleTypes[intRand(1, #obstacleTypes+1)]
        self.scene:addObstacle(randomType, lastLoc)
    end
    self.scene:setSpeed(Settings.speed)
    
    PhysicWorld.start()

    return self
end



function GameState:destroy()
    PhysicWorld.setGravity({x = 0, y = -math.abs(PhysicWorld.getGravity().y)})
    PhysicWorld.stop()
    self.guiRoot:hide()
    self.scene:destroy()
    self.player:destroy()
    self.soundtrack:stop()
end



function GameState:overGame(result)
        StateManager.requestPop()
        StateManager.requestPush("Result", {result_text = result.."\nProgress: "..
                                            (80-self.scene:getObstaclesNum()).."/80"})
end



function GameState:update(deltaTime)
    self.guiRoot:update(deltaTime)
    self.guiRoot:getWidget("progress"):setText("Progress: "..
                                (80-self.scene:getObstaclesNum()).."/80")
    self.scene:update(deltaTime)
    self.player:update(deltaTime)
    if self.player:getPosition().x < -380 then
        self:overGame("Defeat")
    end
    if self.scene:getObstaclesNum() == 0 then
        self:overGame("Victory")
    end
end



function GameState:onKeyboardEvent(key, isPressed)
    if isPressed then
        print(key)
        if key == 27 then     -- escape
            StateManager.requestPop()
            StateManager.requestPush("Menu")
        
        elseif key == 32 then
            PhysicWorld.setGravity({x = 0, y = -PhysicWorld.getGravity().y})
            self.player:setAwake(true)

        elseif key == 481 then     -- shift
            self.player:startAnimation("jump")

        elseif key == 'V' then
            self.player.fixture:setFilter(0)

        end
    end
end



Class.register(GameState, State)

return GameState
