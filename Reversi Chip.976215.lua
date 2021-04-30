-- win button Yellow: 976215
local HIDDEN = true
local POS = {x = 4.75, y = 0.75, z = -0.5}
local ROT = {x = 0, y = 270, z = 0}

function onLoad()
	render()
end

function render()
	local y = HIDDEN and Global.getVar('hiddenY') or 0.75
	local x = HIDDEN and 180 or 0
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotation({x, ROT.y, ROT.z})
	self.setLock(true)
end

function hide()
	HIDDEN = true
	render()
end

function show()
	HIDDEN = false
	render()
end

function handleClick()
	Global.call('handleTrickWin', 'Yellow')
end