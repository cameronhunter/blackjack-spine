Spine = require('spine')

class Pot extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'

  constructor: ->
    super
    @pot.bind 'change', @render
  
  render: =>
    @pot_value.html @pot.size.toFixed(2)
    @win_value.html @pot.winnings().toFixed(2)
    
module.exports = Pot
