Template.pages.show_frontpage = ->
	not Session.get('selected_game')?
Template.pages.show_gamepage = ->
	# This is a hack
	if not Session.get('selected_game')?
		$('#gamepage').addClass('hidden')
	else
		$('#gamepage').removeClass('hidden')
	return ''

Meteor.startup ->
	board = jgo_generateBoard($("#board"))
	board.click = (coord) ->
		game_id = Session.get('selected_game')
		game = Games.findOne {_id: game_id}
		player_id = Session.get('selected_player')
		player = Players.findOne {_id: player_id}
		return unless game? and player?
		return unless game.next is player.color

		opponent = if player.color is 'white' then 'black' else 'white'
		stone = if player.color is 'white' then JGO_WHITE else JGO_BLACK
		captured = board.play(coord, stone)
		tmpboard = []
		for i in [0..18]
			tmpboard[i] = [] unless tmpboard[i]?
			for j in [0..18]
				coordinate = new JGOCoordinate(j, i)
				tmpboard[i][j] = 'white' if board.get(coordinate) is JGO_WHITE
				tmpboard[i][j] = 'black' if board.get(coordinate) is JGO_BLACK
		increment = {moves: 1}
		increment['captured_'+opponent] = captured
		Games.update {_id: game_id}, {$set: {board: tmpboard, next: opponent}, $inc: increment}
	Template.pages.show_gamepage()

	Meteor.autosubscribe ->
		game_id = Session.get('selected_game')
		game = Games.findOne {_id: game_id}
		return unless game?

		player_id = Session.get('selected_player')
		player = Players.findOne {_id: player_id}
		return unless player?

		# Update the whole board accordingly
		board.clearMarkers()
		for i in [0..18]
			for j in [0..18]
				coordinate = new JGOCoordinate(j, i)
				if not game?.board?[i]?[j]?
					board.set(coordinate, JGO_CLEAR)
					if game.next is 'white' and player.color is 'white'
						board.mark(coordinate, '>')
					else if game.next is 'black' and player.color is 'black'
						board.mark(coordinate, '<')
				else if game.board[i][j] is 'white'
					board.set(coordinate, JGO_WHITE)
				else if game.board[i][j] is 'black'
					board.set(coordinate, JGO_BLACK)
				else
					board.set(coordinate, JGO_CLEAR)
					if game.next is 'white' and player.color is 'white'
						board.mark(coordinate, '>')
					else if game.next is 'black' and player.color is 'black'
						board.mark(coordinate, '<')

