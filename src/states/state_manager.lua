local StateManager = {}
local Class = require("class")
local GUI = require("gui.gui")

local states = {}
local requests = {}
local REQUEST = {PUSH = 1, POP = 2, CLEAR = 3}
local registered_states = {}



function StateManager.init()
	GUI.addKeyboardCallback(StateManager.onKeyboardEvent)
end



function StateManager.registerState(id, state)
	registered_states[id] = state
end



function StateManager.haveStates()
	return #states > 0
end



local function processRequests()
	for k, request in pairs(requests) do
		if request.action == REQUEST.PUSH then
			table.insert(states, request.state(request.args))

		elseif request.action == REQUEST.POP then
			states[#states]:destroy()
			table.remove(states)

		elseif request.action == REQUEST.CLEAR then
			for k, _ in pairs(states) do
				states[k]:destroy()
				table.remove(states, k)
			end
			states = {}
		end
	end
	requests = {}
end



function StateManager.update(deltaTime)
	processRequests()
	for k, _ in pairs(states) do
		states[k]:update(deltaTime)
	end
end



function StateManager.requestPush(new_state_id, args)
	assert(registered_states[new_state_id], new_state_id.." state unregistered!")
	table.insert(requests, {action = REQUEST.PUSH, 
							state = registered_states[new_state_id], 
							args = args})
end



function StateManager.requestPop()
	table.insert(requests, {action = REQUEST.POP})
end



function StateManager.requestClear()
	table.insert(requests, {action = REQUEST.CLEAR})
end



function StateManager.onKeyboardEvent(key, isPressed)
	for k, v in pairs(states) do
		v:onKeyboardEvent(key, isPressed)
	end
end



Class.registerSingleton(StateManager)

return StateManager
