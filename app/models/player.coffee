require('spine/lib/relation')

Spine = require('spine')
Pot = require('models/pot')

class Player extends Spine.Model
  @configure 'Player'
  @hasOne 'pot', 'Pot'

  constructor: (pot_size) ->
    @pot = new Pot pot_size

  can_afford: (amount) ->
    @pot.size >= amount

  bets: (amount) -> 
    @pot.debit amount
    @save()

  wins: (amount) ->
    @pot.credit amount
    @save()

module.exports = Player
