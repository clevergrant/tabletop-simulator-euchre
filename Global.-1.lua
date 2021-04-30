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

	Global.setVar('colors', {'Blue', 'Red', 'Teal', 'Yellow'})

	Global.setVar('playArea', {
		Blue = getObjectFromGUID('479892'),
		Red = getObjectFromGUID('cf95dc'),
		Teal = getObjectFromGUID('69778a'),
		Yellow = getObjectFromGUID('db87bb')
	})

	Global.setVar('winArea', {
		Blue = {POS = {x = -3, y = 1, z = -7}, ROT = {0, 180, 0}},
		Red = {POS = {x = -7, y = 1, z = 3}, ROT = {0, 270, 0}},
		Teal = {POS = {x = 3, y = 1, z = 7}, ROT = {0, 0, 0}},
		Yellow = {POS = {x = 7, y = 1, z = -3}, ROT = {0, 90, 0}}
	})

	Global.setVar('winBtns', {
		Blue = getObjectFromGUID('bb3521'),
		Red = getObjectFromGUID('170338'),
		Teal = getObjectFromGUID('92cbc1'),
		Yellow = getObjectFromGUID('976215')
	})

	Global.setVar('selectingDiscard', false)

	Global.setVar('hiddenY', -2)

	Global.setVar('dealer', 'Blue')

	Global.setVar('phase', 1)
	Global.setVar('plays', 0)
	Global.setVar('cardRefs', {Blue = nil, Red = nil, Teal = nil, Yellow = nil})
	Global.setVar('tricksPlayed', 0)

	Wait.time(function()
		if Turns.turn_color ~= 'Blue' then
			Turns.turn_color = 'Blue'
		end
	end, 1)

end

-- The onUpdate event is called once per frame.
-- function onUpdate()
-- end

function onPlayerTurn(player, prev_player)
	setupTurn()
end

function setupTurn()

	local phase = Global.getVar('phase')
	local deck = Global.getVar('deck')
	local dealBtn = Global.getVar('dealBtn')
	local resetDeckBtn = Global.getVar('resetDeckBtn')
	local passBtn = Global.getVar('passBtn')
	-- local goAloneBtn = Global.getVar('goAloneBtn')
	local pickupBtn = Global.getVar('pickupBtn')

	if phase == 1 then

		Global.setVar('dealer', Turns.turn_color)
		Global.setVar('tries', 0)
		deck.reset()

		local dealer = Global.getVar('dealer')

		deck.call('face', {color = dealer})
		dealBtn.call('face', {color = dealer})
		resetDeckBtn.call('face', {color = dealer})

		dealBtn.call('show')

	elseif phase == 2 then

		passBtn.call('face', {color = Turns.turn_color})
		passBtn.call('show')
		pickupBtn.call('face', {color = Turns.turn_color})
		pickupBtn.call('show')

	elseif phase == 3 then
		broadcastToColor('Discard a card from your hand.', Global.getVar('dealer'),
                 		{1, 1, 1})
	end
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
			callback_function = function(card)
				Global.setVar('trump', card)
				Wait.frames(function()
					card.setLock(true)
					Global.setVar('phase', 2)
					Turns.turn_color = Turns.getNextTurnColor()
				end, 40)
			end
		})
		deck.setLock(true)
	end, 300)

end

function handlePass()

	Global.getVar('passBtn').call('hide')
	Global.getVar('pickupBtn').call('hide')

	Global.setVar('tries', Global.getVar('tries') + 1)
	local tries = Global.getVar('tries')

	local trump = Global.getVar('trump')

	if tries < 4 and trump == nil then
		print('You need to deal the cards first!')
		return
	end

	if tries == 4 then
		-- flip over the kiddie and start over
		local deck = Global.getVar('deck')
		trump.setLock(false)
		trump.flip()
		deck.setLock(false)
		Wait.time(function()
			deck.putObject(trump)
			deck.setLock(true)
			local pickupBtnUI = Global.getVar('pickupBtn').UI
			pickupBtnUI.setAttribute('pickup-button', 'text', 'Choose Suit')
			pickupBtnUI.setAttribute('pickup-button', 'textColor', '#ffffff')
		end, 1)
	elseif tries == 8 then
		Global.getVar('deck').reset()
		Global.setVar('phase', 1)
		Global.getVar('passBtn').call('hide')
		Global.getVar('pickupBtn').call('hide')
	end
	Wait.frames(function()
		Turns.turn_color = Turns.getNextTurnColor()
	end, 10)
end

function getTurnOrder()
	if Turns.turn_color == 'Blue' then
		return {'Red', 'Teal', 'Yellow', 'Blue'}
	elseif Turns.turn_color == 'Red' then
		return {'Teal', 'Yellow', 'Blue', 'Red'}
	elseif Turns.turn_color == 'Teal' then
		return {'Yellow', 'Blue', 'Red', 'Teal'}
	else
		return {'Blue', 'Red', 'Teal', 'Yellow'}
	end
end

function handlePickup()
	Global.getVar('passBtn').call('hide')
	Global.getVar('pickupBtn').call('hide')
	Global.getVar('goAloneBtn').call('hide')

	-- put the trump in the dealer's hand
	local trump = Global.getVar('trump')
	local dealer = Global.getVar('dealer')

	if trump ~= nil then
		-- deck.setLock(false)
		trump.setLock(false)
		trump.use_hands = true
		trump.deal(1, dealer)
		Global.setVar('selectingDiscard', true)
		Global.setVar('phase', 3)
		Turns.turn_color = dealer
	else
		Global.setVar('phase', 4)
		local leftOfDealer = getLeftOfDealer()
		if Turns.turn_color ~= leftOfDealer then
			Turns.turn_color = leftOfDealer
		end
	end
end

function onPlayerAction(player, action, targets)
	handleDiscard(player, action, targets)
	handlePlayCard(player, action, targets)
end

function handleDiscard(player, action, targets)

	local discarding = Global.getVar('selectingDiscard')
	local isPickup = action == Player.Action.PickUp
	local isDealer = player.color == Turns.turn_color

	if discarding and isPickup and isDealer then

		local card = targets[1]
		local deck = Global.getVar('deck')

		deck.setLock(false)
		deck.putObject(card)
		deck.setLock(true)

		broadcastToAll(player.steam_name .. ' has discarded.')

		-- deck.call('hide')

		for _, p in ipairs(Player.getPlayers()) do
			if p.color == Global.getVar('currentTurn') then
				broadcastToAll('It\'s ' .. p.steam_name .. '\'s turn.')
			end
		end

		-- it sets this too quickly by default, this just allows the card
		-- to finish being discarded before continuing
		Wait.time(function()
			Global.setVar('selectingDiscard', false)
		end, 1)

		Global.setVar('phase', 4)
		Turns.turn_color = Turns.getNextTurnColor()
	end
end

function handlePlayCard(player, action, targets)

	local discarding = Global.getVar('selectingDiscard')
	local isPickup = action == Player.Action.PickUp
	local isPlayersTurn = player.color == Turns.turn_color

	if not discarding and isPickup and isPlayersTurn then

		Global.setVar('plays', Global.getVar('plays') + 1)

		local card = targets[1]
		local playArea = Global.getVar('playArea')[Turns.turn_color]

		card.setPositionSmooth(playArea.getPosition(), false, true)
		card.setLock(true)

		Global.getVar('cardRefs')[Turns.turn_color] = card

		checkTrick()

	end
end

function checkTrick()
	if Global.getVar('plays') >= 4 then
		Global.setVar('tricksPlayed', Global.getVar('tricksPlayed') + 1)
		local winBtns = Global.getVar('winBtns')
		for _, color in ipairs(Global.getVar('colors')) do
			winBtns[color].call('show')
		end
	else
		Turns.turn_color = Turns.getNextTurnColor()
	end
end

function handleTrickWin(color)
	print(color .. ' wins!')
	Global.setVar('plays', 0)

	for _, c in ipairs(Global.getVar('colors')) do
		local card = Global.getVar('cardRefs')[c]
		card.setPositionSmooth(Global.getVar('winArea')[color].POS, false, true)
		card.setRotationSmooth(Global.getVar('winArea')[color].ROT, false, true)
		Wait.time(function()
			card.setLock(true)
		end, 1)
		Global.getVar('winBtns')[c].call('hide')
	end

	if Global.getVar('tricksPlayed') >= 5 then
		local newDealer = getLeftOfDealer()
		Global.setVar('dealer', newDealer)
		Global.setVar('tricksPlayed', 0)
		Global.setVar('phase', 1)
		Turns.turn_color = newDealer
	else
		print(color .. ' starts the next trick.')
		if Turns.turn_color ~= color then
			Turns.turn_color = color
		end
	end
end

function getLeftOfDealer()
	local dealer = Global.getVar('dealer')
	if dealer == 'Blue' then
		return 'Red'
	elseif dealer == 'Red' then
		return 'Teal'
	elseif dealer == 'Teal' then
		return 'Yellow'
	else
		return 'Blue'
	end
end