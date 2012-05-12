Spine = require('spine')
Player = require('models/player')

class Bank extends Spine.Controller

  elements:
    '.value': 'bank_value'

  constructor: ->
    super
    @player.bind 'change', @render
  
  render: =>
    @bank_value.html @player.pot.size.toFixed(2)
    
module.exports = Bank
