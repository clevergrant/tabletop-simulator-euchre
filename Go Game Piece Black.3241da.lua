-- Black Minus: 3241da
function onLoad()
	self.setPosition({9.5, 1.1, 8.5})
	self.setRotation({0, 270, 0})
	self.setLock(false)
end

function subtract()
	local score = Global.getVar('blackScoreCard')
	score.call('subtract')
end