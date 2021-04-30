-- Red Plus: b60836
function onLoad()
	self.setPosition({8.5, 0.7, -8})
	self.setLock(true)
end

function add()
	local score = Global.getVar('redScoreCard')
	score.call('add')
end