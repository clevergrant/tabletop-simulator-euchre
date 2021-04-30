-- Blue Checkerboard piece: d30eff
local DISTANCE_FROM_CENTER = 9.5

local HIDDEN = false
local POS = {x = 0, y = 0.8, z = DISTANCE_FROM_CENTER * -1}
local ROT = {x = 0, y = 0, z = 0}

function onLoad()
	render()
end

function render()
	local y = HIDDEN and Global.getVar('hiddenY') or 0.8
	local x = HIDDEN and 180 or 0
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotationSmooth({x, ROT.y, ROT.z}, false, true)
	self.setLock(true)
end

function face(params)
	if params.color == 'Blue' then
		POS.x = 0
		POS.z = DISTANCE_FROM_CENTER * -1
		ROT.y = 0
	elseif params.color == 'Red' then
		POS.x = DISTANCE_FROM_CENTER * -1
		POS.z = 0
		ROT.y = 90
	elseif params.color == 'Teal' then
		POS.x = 0
		POS.z = DISTANCE_FROM_CENTER
		ROT.y = 180
	else
		POS.x = DISTANCE_FROM_CENTER
		POS.z = 0
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

function dealTrick()
	Global.call('dealTrick')
	hide()
end