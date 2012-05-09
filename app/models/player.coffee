require('spine/lib/relation')

Spine = require('spine')
Pot = require('models/pot')

class Player extends Spine.Model
  @configure 'Player'
  @hasOne 'pot', 'Pot'

  constructor: ->
    @pot = new Pot
  
module.exports = Player
