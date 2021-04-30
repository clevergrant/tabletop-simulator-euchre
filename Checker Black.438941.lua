-- Black Checkerboard Piece: 438941
local HIDDEN = true
local POS = {x = -5.5, y = Global.getVar('hiddenY'), z = 0	}
local ROT = {x = 180, y = 90, z = 0}

function onLoad()
	hide()
end

function render()
	-- local y = HIDDEN and Global.getVar('hiddenY') or 1
	local y = Global.getVar('hiddenY')
	local x = HIDDEN and 180 or 0
	self.setPositionSmooth({POS.x, y, POS.z}, false, true)
	self.setRotationSmooth({x, ROT.y, ROT.z}, false, true)
	self.setLock(true)
end

function face(params)
	if params.color == 'Blue' then
		POS.x = 0
		POS.z = -5.5
		ROT.y = 0
	elseif params.color == 'Red' then
		POS.x = -5.5
		POS.z = 0
		ROT.y = 90
	elseif params.color == 'Teal' then
		POS.x = 0
		POS.z = 5.5
		ROT.y = 180
	else
		POS.x = 5.5
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

function alone()
end