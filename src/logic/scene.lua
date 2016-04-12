local Scene = {}
local Class = require("class")
local Entity = require("logic.entity")
local PhysicWorld = require("logic.physic_world")
local Wall = require("logic.wall")


function Scene.new(player)
    local self = {}
    self.floor = Wall(-410, Wall.Orientation.Horisontal)
    self.floor.fixture.floor = true
    self.ceil = Wall(410, Wall.Orientation.Horisontal)
    self.ceil.fixture.ceil = true

    self.obstaclesQuery = {}
    self.obstacles = {}
    self.speed = 333
    self.passedDistance = 0
    self.player = player

    return self
end



function Scene:destroy()
    for k, v in pairs(self.obstacles) do v:destroy() end
    self.floor:destroy()
    self.ceil:destroy()
end



function Scene:addObstacle(ObstacleType, xPos)
    self.obstaclesQuery[xPos] = ObstacleType
end



function Scene:setSpeed(speed)
    self.speed = speed
end



function Scene:getObstaclesNum()
    local obstaclesNum = 0
    for k, v in pairs(self.obstaclesQuery) do
        obstaclesNum = obstaclesNum + 1
    end
    for k, v in pairs(self.obstacles) do
        obstaclesNum = obstaclesNum + 1
    end

    return obstaclesNum
end



function Scene:update(deltaTime)
    self.passedDistance = self.passedDistance + self.speed*deltaTime
    for k, v in pairs(self.obstaclesQuery) do
        if k  < self.passedDistance + 500 then
            local obstacle = v {xPos = (k > 500) and 500 or k, filter_mask = 0x2}
            obstacle:setLinearVelocity(-self.speed, nil)
            table.insert(self.obstacles, obstacle)
            self.obstaclesQuery[k] = nil
        end
    end
    for k, v in pairs(self.obstacles) do
        if v.destroyed then
            table.remove(self.obstacles, k)
        else
            v:update(deltaTime)
            if v:getPosition().x < -500 then
                v:destroy()
                table.remove(self.obstacles, k)
            end
        end
    end
end



Class.register(Scene)

return Scene