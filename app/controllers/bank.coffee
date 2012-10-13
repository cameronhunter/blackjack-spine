Spine = require('spine')
Player = require('models/player')

class Bank extends Spine.Controller

  elements:
    '.value': 'bank_value'

  constructor: ->
    super
    @html require('views/bank')()
    Player.bind 'change', @render

  render: (player, b, c) =>
    @bank_value.html player.pot.size.toFixed(2)

module.exports = Bank
