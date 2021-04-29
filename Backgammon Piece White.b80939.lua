-- Pickup Button: b80939
HIDDEN = true
POS = {x = 3, y = -2, z = -5}
ROT = {0, 90, 0}

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
		POS.x = 3
		POS.z = -5
		ROT = {0, 0, 0}
	elseif params.color == 'Orange' then
		POS.x = -5
		POS.z = -3
		ROT = {0, 90, 0}
	elseif params.color == 'Green' then
		POS.x = -3
		POS.z = 5
		ROT = {0, 180, 0}
	else
		POS.x = 5
		POS.z = 3
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

function pickup()
	Global.call('handlePickup')
end