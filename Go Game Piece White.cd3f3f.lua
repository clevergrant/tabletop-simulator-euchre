-- Black Plus: cd3f3f
function onLoad()
	self.setPosition({8, 0.7, 8.5})
	self.setRotation({0, 270, 0})
	self.setLock(true)
end

function add()
	local score = Global.getVar('blackScoreCard')
	score.call('add')
end