Spine = require('spine')

class Pot extends Spine.Controller
  tag: 'section'; className: 'pot row'

  elements:
    '.winner': 'winner'
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'
    '.winner .value': 'winner_message'

  constructor: ->
    super
    @html require('views/pot')()
    @pot.bind 'change', @render
    Spine.bind 'result', @show_winner
  
  show_winner: (message) =>
    @winner_message.html message
    @winner.removeClass 'hidden'
  
  render: =>
    @pot_value.html @pot.size.toFixed(2)
    @win_value.html @pot.winnings().toFixed(2)
    
module.exports = Pot
