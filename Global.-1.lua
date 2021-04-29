-- Lua code. See documentation: https://api.tabletopsimulator.com/
-- The onLoad event is called after the game save finishes loading.
function onLoad()
	Turns.enable = true
	Turns.type = 1
	Turns.disable_interactations = true
	Turns.pass_turns = false

	Global.setVar('passBtn', getObjectFromGUID('a7d6e1'))
	Global.setVar('pickupBtn', getObjectFromGUID('b80939'))
	Global.setVar('blackScoreCard', getObjectFromGUID('9a737a'))
	Global.setVar('blackScoreCardBottom', getObjectFromGUID('91bfeb'))
	Global.setVar('redScoreCardBottom', getObjectFromGUID('485ade'))
	Global.setVar('redScoreCard', getObjectFromGUID('a9bdc5'))
	Global.setVar('goAloneBtn', getObjectFromGUID('438941'))
	Global.setVar('resetDeckBtn', getObjectFromGUID('072e38'))
	Global.setVar('dealBtn', getObjectFromGUID('d30eff'))
	Global.setVar('deck', getObjectFromGUID('dd9b4e'))
	Global.setVar('redMinusBtn', getObjectFromGUID('0e9cbe'))
	Global.setVar('blackMinusBtn', getObjectFromGUID('3241da'))
	Global.setVar('redPlusBtn', getObjectFromGUID('b60836'))
	Global.setVar('blackPlusBtn', getObjectFromGUID('cd3f3f'))

	setupTurn()
end

-- The onUpdate event is called once per frame.
-- function onUpdate()
-- end

function onPlayerTurn(player, last_player)
	print('current player: ', player)
	print('last player: ', last_player)
	setupTurn()
end

function dealTrick()

	-- check if there are 4 players
	local players = 0
	local playerList = getSeatedPlayers()
	for _ in ipairs(playerList) do
		players = players + 1
	end
	if players ~= 4 then
		print('You need 4 players to play this game.')
		return
	end

	local deck = Global.getVar('deck')
	deck.shuffle()

	local turnOrder = getTurnOrder()

	local extra = false
	for i = 1, 4 do
		if extra then
			Wait.frames(function()
				deck.deal(3, turnOrder[i])
			end, 30 * i)
		else
			Wait.frames(function()
				deck.deal(2, turnOrder[i])
			end, 30 * i)
		end
		extra = not extra
	end
	for i = 1, 4 do
		if extra then
			Wait.frames(function()
				deck.deal(2, turnOrder[i])
			end, 120 + 30 * i)
		else
			Wait.frames(function()
				deck.deal(3, turnOrder[i])
			end, 120 + 30 * i)
		end
		extra = not extra
	end

	local deckPosition = deck.getPosition()
	deckPosition.y = deckPosition.y + .25
	Wait.frames(function()
		deck.takeObject({
			flip = true,
			position = deckPosition,
			smooth = true,
			callback_function = setTrumpCard
		})
		deck.setLock(true)
	end, 300)

	Wait.frames(function()
		Global.getVar('passBtn').call('show')
		Global.getVar('goAloneBtn').call('show')
		Global.getVar('pickupBtn').call('show')
	end, 400)
end

function setTrumpCard(card)
	Global.setVar('TRUMPCARD', card)
	Wait.frames(function()
		card.setLock(true)
	end, 10)
end

function setupTurn()

	Global.setVar('TRIES', 0)

	local deck = Global.getVar('deck')
	deck.reset()

	local dealBtn = Global.getVar('dealBtn')
	local resetDeckBtn = Global.getVar('resetDeckBtn')

	local passBtn = Global.getVar('passBtn')
	local goAloneBtn = Global.getVar('goAloneBtn')
	local pickupBtn = Global.getVar('pickupBtn')

	local nextColor = Turns.getNextTurnColor()

	dealBtn.call('show')

	passBtn.call('hide')
	goAloneBtn.call('hide')
	pickupBtn.call('hide')

	-- move all necessary pieces
	deck.call('face', {color = Turns.turn_color})
	dealBtn.call('face', {color = Turns.turn_color})
	resetDeckBtn.call('face', {color = Turns.turn_color})
	goAloneBtn.call('face', {color = nextColor})
	passBtn.call('face', {color = nextColor})
	pickupBtn.call('face', {color = nextColor})

end

function handlePass()

	Global.setVar('TRIES', Global.getVar('TRIES') + 1)
	local TRIES = Global.getVar('TRIES')

	local trump = Global.getVar('TRUMPCARD')

	if trump == nil then
		print('You need to deal the cards first!')
		return
	end

	local turnOrder = getTurnOrder()

	local goAloneBtn = Global.getVar('goAloneBtn')
	local passBtn = Global.getVar('passBtn')
	local pickupBtn = Global.getVar('pickupBtn')

	if TRIES == 1 then
		goAloneBtn.call('face', {color = turnOrder[2]})
		passBtn.call('face', {color = turnOrder[2]})
		pickupBtn.call('face', {color = turnOrder[2]})
	elseif TRIES == 2 then
		goAloneBtn.call('face', {color = turnOrder[3]})
		passBtn.call('face', {color = turnOrder[3]})
		pickupBtn.call('face', {color = turnOrder[3]})
	elseif TRIES == 3 then
		goAloneBtn.call('face', {color = turnOrder[4]})
		passBtn.call('face', {color = turnOrder[4]})
		pickupBtn.call('face', {color = turnOrder[4]})
	elseif TRIES == 4 then
		-- flip over the kiddie and start over
		local deck = Global.getVar('deck')
		trump.setLock(false)
		trump.flip()
		deck.setLock(false)
		-- deck = deck.putObject(trump)
		deck.setLock(true)
		Wait.time(function()
			trump.setLock(true)
		end, 1)
		goAloneBtn.call('face', {color = turnOrder[1]})
		passBtn.call('face', {color = turnOrder[1]})
		pickupBtn.call('face', {color = turnOrder[1]})
	elseif TRIES == 5 then
		goAloneBtn.call('face', {color = turnOrder[2]})
		passBtn.call('face', {color = turnOrder[2]})
		pickupBtn.call('face', {color = turnOrder[2]})
	elseif TRIES == 6 then
		goAloneBtn.call('face', {color = turnOrder[3]})
		passBtn.call('face', {color = turnOrder[3]})
		pickupBtn.call('face', {color = turnOrder[3]})
	elseif TRIES == 7 then
		goAloneBtn.call('face', {color = turnOrder[4]})
		passBtn.call('face', {color = turnOrder[4]})
		pickupBtn.call('face', {color = turnOrder[4]})
	else
		Global.getVar('resetDeckBtn').call('resetDeck')
		goAloneBtn.call('face', {color = turnOrder[1]})
		passBtn.call('face', {color = turnOrder[1]})
		pickupBtn.call('face', {color = turnOrder[1]})
		TRIES = 8;
	end
end

function getTurnOrder()
	if Turns.turn_color == 'White' then
		return {'Orange', 'Green', 'Purple', 'White'}
	elseif Turns.turn_color == 'Orange' then
		return {'Green', 'Purple', 'White', 'Orange'}
	elseif Turns.turn_color == 'Green' then
		return {'Purple', 'White', 'Orange', 'Green'}
	else
		return {'White', 'Orange', 'Green', 'Purple'}
	end
end

function handlePickup()
	Global.getVar('passBtn').call('hide')
	Global.getVar('pickupBtn').call('hide')
	Global.getVar('goAloneBtn').call('hide')

	-- put the trump in the dealer's hand
	local trump = Global.getVar('TRUMPCARD')
	local dealer = Turns.turn_color

	local colors = getTurnOrder()

	-- for _, player in ipairs(Player.getPlayers()) do
	-- 	if player.
	-- end

	trump.setLock(false)
	trump.use_hands = true
	trump.deal(1, dealer)
end

function onPlayerAction(player, action, targets)

	print(player.drag)

	-- local holding = player.getHoldingObjects()
	-- local size = 0
	-- for _, obj in ipairs(holding) do
	-- 	print(obj)
	-- 	size = size + 1
	-- end
end
