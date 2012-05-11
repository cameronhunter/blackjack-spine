Spine = require('spine')
Pot   = require('controllers/pot')

class Actions extends Spine.Controller

  elements:
    '.deal': 'deal_button'
    '.bet': 'bet_buttons'
    '.action': 'action_buttons'

  events:
    'click .deal': 'deal'

  constructor: ->
    super
    @html require('views/actions')()
    @setup()
  
  setup: ->
    show @deal_button
    show @bet_buttons
    hide @action_buttons
  
  deal: ->
    hide @deal_button
    hide @bet_buttons
    show @action_buttons
  
  # Private
  
  hide = (selection) ->
    selection.hide()
    
  show = (selection) ->
    selection.show()
  
module.exports = Actions
