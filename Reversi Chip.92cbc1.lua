-- win button Teal: 92cbc1
local HIDDEN = true
local POS = {x = 0.5, y = 0.75, z = 4.75}
local ROT = {x = 0, y = 180, z = 0}

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
	Global.call('handleTrickWin', 'Teal')
end