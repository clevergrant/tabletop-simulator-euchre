-- Red Checkerboard piece: 072e38
DISTANCE_FROM_CENTER = 11

function onLoad()
	self.setLock(true)
end

function face(params)
	if params.color == 'White' then
		self.setPositionSmooth({0, 1, DISTANCE_FROM_CENTER * -1}, false, true)
		self.setRotationSmooth({0, 0, 0}, false, true)
	elseif params.color == 'Orange' then
		self.setPositionSmooth({DISTANCE_FROM_CENTER * -1, 1, 0}, false, true)
		self.setRotationSmooth({0, 90, 0}, false, true)
	elseif params.color == 'Green' then
		self.setPositionSmooth({0, 1, DISTANCE_FROM_CENTER}, false, true)
		self.setRotationSmooth({0, 180, 0}, false, true)
	else
		self.setPositionSmooth({DISTANCE_FROM_CENTER, 1, 0}, false, true)
		self.setRotationSmooth({0, 270, 0}, false, true)
	end
end

function resetDeck()
	Global.call('setupTurn')
	-- TODO: figure out how to end turn
end