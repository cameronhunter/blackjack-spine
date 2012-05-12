Spine = require('spine')

class Pot extends Spine.Controller

  elements:
    '.winner': 'winner'
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'
    '.winner .value': 'winner_message'

  constructor: ->
    super
    Spine.bind 'result', @show_winner
    @pot.bind 'change', @render
  
  show_winner: (message) =>
    @winner_message.html message
    @winner.removeClass 'hidden'
  
  render: =>
    @pot_value.html @pot.size.toFixed(2)
    @win_value.html @pot.winnings().toFixed(2)
    
module.exports = Pot
