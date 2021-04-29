-- Deck: dd9b4e
function onLoad()
	self.shuffle()
	self.setLock(true)
end

function face(params)
	if params.color == 'White' then
		self.setPositionSmooth({0, 1, -7}, false, true)
		self.setRotationSmooth({0, 0, 180}, false, true)
	elseif params.color == 'Orange' then
		self.setPositionSmooth({-7, 1, 0}, false, true)
		self.setRotationSmooth({0, 90, 180}, false, true)
	elseif params.color == 'Green' then
		self.setPositionSmooth({0, 1, 7}, false, true)
		self.setRotationSmooth({0, 180, 180}, false, true)
	else
		self.setPositionSmooth({7, 1, 0}, false, true)
		self.setRotationSmooth({0, 270, 180}, false, true)
	end
end