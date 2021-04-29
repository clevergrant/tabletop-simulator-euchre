-- 5 clubs (black top score card): 9a737a
SCORE = 0

function onLoad()
	-- print('POS: ', self.getPosition())
	-- print('ROT: ', self.getRotation())
	setPos()
	self.setLock(false)
end

function setPos()
	if SCORE == 0 then
		self.setPositionSmooth({9, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 135, 180}, false, true)
	elseif SCORE == 1 then
		self.setPositionSmooth({9.53, 1.1, 6.15}, false, true)
		self.setRotationSmooth({0, 135, 180}, false, true)
	elseif SCORE == 2 then
		self.setPositionSmooth({9.78, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 180, 180}, false, true)
	elseif SCORE == 3 then
		self.setPositionSmooth({10.4, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 180, 180}, false, true)
	elseif SCORE == 4 then
		self.setPositionSmooth({10.83, 1.1, 6.4}, false, true)
		self.setRotationSmooth({0, 135, 180}, false, true)
	elseif SCORE == 5 then
		self.setPositionSmooth({9, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 90, 360}, false, true)
	elseif SCORE == 6 then
		self.setPositionSmooth({9.7, 1.1, 6.1}, false, true)
		self.setRotationSmooth({0, 135, 0}, false, true)
	elseif SCORE == 7 then
		self.setPositionSmooth({9.73, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 180, 0}, false, true)
	elseif SCORE == 8 then
		self.setPositionSmooth({10.4, 1.1, 6}, false, true)
		self.setRotationSmooth({0, 180, 0}, false, true)
	elseif SCORE == 9 then
		self.setPositionSmooth({10.83, 1.1, 6.4}, false, true)
		self.setRotationSmooth({0, 135, 0}, false, true)
	else
		flipTable()
	end
end

function subtract()
	if SCORE > 0 then
		SCORE = SCORE - 1
		if SCORE == 4 then
			self.flip()
		end
		setPos()
	end
end

function add()
	if SCORE < 10 then
		SCORE = SCORE + 1
		if SCORE == 5 then
			self.flip()
		end
		setPos()
	end
end