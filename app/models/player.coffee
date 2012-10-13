Spine = require('spine')
Pot = require('models/pot')

class Player extends Spine.Model
  @configure 'Player', 'pot'

  bets: (amount) ->
    @pot.debit amount
    @save()

  wins: (amount) ->
    @pot.credit amount
    @save()

module.exports = Player
