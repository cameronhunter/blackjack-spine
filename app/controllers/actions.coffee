Spine = require('spine')

class Actions extends Spine.Controller

  elements:
    '.deal': 'deal_button'
    '.bet': 'bet_buttons'
    '.action': 'action_buttons'

  events:
    'click .deal': 'deal'
    'click .surrender': 'setup'

  constructor: ->
    super
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
    enable selection.show()
    
  disable = (selection) ->
    selection.attr('disabled', true)
    
  enable = (selection) ->
    selection.removeAttr('disabled')
  
module.exports = Actions
