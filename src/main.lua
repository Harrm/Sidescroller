io.output("log.txt")


math.randomseed(os.clock())
intRand = function(l, r) 
    l = l or 0
    r = r or l
    return l + math.fmod(math.floor(math.random()*10000), r - l)
end

setmetatable(_G, {__newindex = function(t, k) error("Undeclared variable "..k) end})
setmetatable(_G, {__index = function(t, k) error("Undeclared variable "..k) end})

--MOAISim.setStep(1 / 60)
local GUI = require("gui.gui")
GUI.openWindow("Rise", 800, 600)

local Game = require("game")

print(os.date("%X %x", os.time()))

local gameThread = MOAICoroutine.new()
gameThread:run(Game.run)
