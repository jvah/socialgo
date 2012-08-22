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
	
