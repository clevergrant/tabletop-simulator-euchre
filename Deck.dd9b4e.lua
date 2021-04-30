-- Deck: dd9b4e
local HIDDEN = false
local POS = {x = 0, y = 1, z = -7}
local ROT = {x = 0, y = 0, z = 180}

function onLoad()
	self.shuffle()
	self.use_hands = false
	render()
end

function render()
	local y = HIDDEN and -3 or 1
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotationSmooth({ROT.x, ROT.y, ROT.z}, false, true)
	self.setLock(true)
end

function face(params)
	if params.color == 'Blue' then
		POS.x = 0
		POS.z = -7
		ROT.y = 0
	elseif params.color == 'Red' then
		POS.x = -7
		POS.z = 0
		ROT.y = 90
	elseif params.color == 'Teal' then
		POS.x = 0
		POS.z = 7
		ROT.y = 180
	else
		POS.x = 7
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