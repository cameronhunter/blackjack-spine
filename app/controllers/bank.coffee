Spine = require('spine')

class Bank extends Spine.Controller

  elements:
    '.value': 'bank_value'

  constructor: ->
    super
    @html require('views/bank')()
    @player.bind 'change', @render
  
  render: =>
    @bank_value.html @player.pot.size.toFixed(2)
    
module.exports = Bank
