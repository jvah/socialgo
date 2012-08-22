Template.frontpage.games_available = ->
	Games.find {finished: {$ne: true}}
Template.frontpage.players_available = ->
	Players.find {available: true}
Template.frontpage.events =
	'click button[name=join_game]': ->
		game = Games.findOne {name: $('select[name=games] option:selected').val()}
		player = Players.findOne {name: $('select[name=players] option:selected').val()}
		if not game?
			alert('Please select a game first')
			return
		if not player?
			alert('Please select a player first')
			return
		Session.set('selected_game', game._id)
		Session.set('selected_player', player._id)
		Players.update {_id: player._id}, {$set: {gameid: game._id}}
	'click button[name=new_game]': ->
		gamename = $('input[name=new_game]').val()
		if gamename.length < 3
			alert('Please write at least 3 characters in game name')
			return
		if Games.find({name: gamename}).count() > 0
			alert('Game already exists')
			return
		Games.insert
			name: gamename
			next: 'black'
	'click button[name=new_player]': ->
		playername = $('input[name=new_player_name]').val()
		playercolor = $('input[name=new_player_color]:checked').val()
		if playername.length < 3
			alert('Please write at least 3 characters in game name')
			return
		if Players.find({name: playername}).count() > 0
			alert('Player already exists')
			return
		Players.insert
			name: playername
			color: playercolor
			available: true
