-- Pass Button: a7d6e1
local HIDDEN = true
local POS = {x = -5, y = Global.getVar('hiddenY'), z = 3}
local ROT = {x = 0, y = 90, z = 0}

function onLoad()
	render()
end

function render()
	local y = HIDDEN and Global.getVar('hiddenY') or 1
	local x = HIDDEN and 180 or 0
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotationSmooth({x, ROT.y, ROT.z}, false, true)
	self.setLock(true)
end

function face(params)
	if params.color == 'Blue' then
		POS.x = -3
		POS.z = -5
		ROT.y = 0
	elseif params.color == 'Red' then
		POS.x = -5
		POS.z = 3
		ROT.y = 90
	elseif params.color == 'Teal' then
		POS.x = 3
		POS.z = 5
		ROT.y = 180
	else
		POS.x = 5
		POS.z = -3
		ROT.y = 270
	end
	render()
end

function hide()
	HIDDEN = true
	render()
end

function show()
	HIDDEN = false
	render()
end

function pass()
	Global.call('handlePass')
end