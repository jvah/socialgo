Template.header.our_color = ->
	player_id = Session.get('selected_player')
	player = Players.findOne {_id: player_id}
	return 'UNKNOWN' unless player?
	return player.color.toUpperCase()
Template.header.is_turn = ->
	game_id = Session.get('selected_game')
	game = Games.findOne {_id: game_id}
	player_id = Session.get('selected_player')
	player = Players.findOne {_id: player_id}
	return false unless game? and player?
	game.next is player.color
Template.header.captured_white = ->
	game_id = Session.get('selected_game')
	game = Games.findOne {_id: game_id}
	return 0 unless game? and game.captured_white?
	return game.captured_white
Template.header.captured_black = ->
	game_id = Session.get('selected_game')
	game = Games.findOne {_id: game_id}
	return 0 unless game? and game.captured_black?
	return game.captured_black
