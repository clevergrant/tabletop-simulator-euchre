-- 5 diamonds (red top score card): a9bdc5
SCORE = 0

function onLoad()
	-- print('POS: ', self.getPosition())
	-- print('ROT: ', self.getRotation())
	setPos()
	self.setLock(true)
end

function setPos()
	if SCORE == 0 then
		self.setPositionSmooth({6, 1.1, -9}, false, true)
		self.setRotationSmooth({0, 225, 180}, false, true)
	elseif SCORE == 1 then
		self.setPositionSmooth({6.15, 1.1, -9.53}, false, true)
		self.setRotationSmooth({0, 225, 180}, false, true)
	elseif SCORE == 2 then
		self.setPositionSmooth({6, 1.1, -9.78}, false, true)
		self.setRotationSmooth({0, 270, 180}, false, true)
	elseif SCORE == 3 then
		self.setPositionSmooth({6, 1.1, -10.4}, false, true)
		self.setRotationSmooth({0, 270, 180}, false, true)
	elseif SCORE == 4 then
		self.setPositionSmooth({6.4, 1.1, -10.83}, false, true)
		self.setRotationSmooth({0, 225, 180}, false, true)
	elseif SCORE == 5 then
		self.setPositionSmooth({6, 1.1, -9}, false, true)
		self.setRotationSmooth({0, 180, 0}, false, true)
	elseif SCORE == 6 then
		self.setPositionSmooth({6.1, 1.1, -9.7}, false, true)
		self.setRotationSmooth({0, 225, 0}, false, true)
	elseif SCORE == 7 then
		self.setPositionSmooth({6, 1.1, -9.73}, false, true)
		self.setRotationSmooth({0, 270, 0}, false, true)
	elseif SCORE == 8 then
		self.setPositionSmooth({6, 1.1, -10.4}, false, true)
		self.setRotationSmooth({0, 270, 0}, false, true)
	elseif SCORE == 9 then
		self.setPositionSmooth({6.4, 1.1, -10.83}, false, true)
		self.setRotationSmooth({0, 225, 0}, false, true)
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