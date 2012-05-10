require('spine/lib/relation')

Spine = require('spine')
Pot = require('models/pot')

class Player extends Spine.Model
  @configure 'Player'
  @hasOne 'pot', 'Pot'

  constructor: ->
    @pot = new Pot

  bets: (amount) ->
    @pot.debit amount

  wins: (amount) ->
    @pot.credit amount

module.exports = Player
