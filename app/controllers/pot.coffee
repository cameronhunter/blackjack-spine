Spine = require('spine')
Bank  = require('models/pot')

class Pot extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'

  constructor: ->
    super
    @html require('views/pot')()
    @pot = new Bank @size
    @pot.bind 'change', @render
  
  add: (amount) ->
    @pot.credit amount
    @pot.save()
  
  winnings: ->
    @pot.size * (@odds ? 1)
  
  render: =>
    @pot_value.html @pot.size.toFixed(2)
    @win_value.html @winnings().toFixed(2)
    
module.exports = Pot
