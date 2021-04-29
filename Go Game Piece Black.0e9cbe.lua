-- Red Minus: 0e9cbe
function onLoad()
	self.setPosition({8.5, 1.1, -9.5})
	self.setLock(true)
end

function subtract()
	local score = Global.getVar('redScoreCard')
	score.call('subtract')
end