Games = new Meteor.Collection('games')
# { board: [...],
#   players: [{player_id, name}], winners: [player_id] }

Players = new Meteor.Collection('players')
# {name: 'foo'}

if Meteor.is_server
	Games.remove({})
	Players.remove({})
