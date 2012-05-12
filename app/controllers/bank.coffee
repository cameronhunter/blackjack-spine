Spine = require('spine')
Player = require('models/player')

class Bank extends Spine.Controller

  elements:
    '.value': 'bank_value'

  constructor: ->
    super
    Player.bind 'change', @render
  
  render: (player) =>
    #@bank_value.html player.pot.size.toFixed(2)
    
module.exports = Bank
