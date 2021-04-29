-- White Checkerboard piece: d30eff
DISTANCE_FROM_CENTER = 9.5

HIDDEN = false
POS = {x = 0, y = 1, z = DISTANCE_FROM_CENTER * -1}
ROT = {0, 0, 0}

function onLoad()
	render()
end

function render()
	local y = HIDDEN and -2 or 1
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotationSmooth(ROT, false, true)
	self.setLock(true)
end

function face(params)
	if params.color == 'White' then
		POS.x = 0
		POS.z = DISTANCE_FROM_CENTER * -1
		ROT = {0, 0, 0}
	elseif params.color == 'Orange' then
		POS.x = DISTANCE_FROM_CENTER * -1
		POS.z = 0
		ROT = {0, 90, 0}
	elseif params.color == 'Green' then
		POS.x = 0
		POS.z = DISTANCE_FROM_CENTER
		ROT = {0, 180, 0}
	else
		POS.x = DISTANCE_FROM_CENTER
		POS.z = 0
		ROT = {0, 270, 0}
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