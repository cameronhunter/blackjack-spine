Spine = require('spine')

class Actions extends Spine.Controller

  elements:
    '.deal': 'deal_button'
    '.continue': 'continue_button'
    '.surrender': 'surrender_button'
    '.bet': 'bet_buttons'
    '.action': 'action_buttons'

  events:
    'click .deal': 'deal'

  constructor: ->
    super
    Spine.bind 'winner', @finished
    @setup()
  
  setup: =>
    show @bet_buttons
    hide @action_buttons
    hide @continue_button
  
  deal: =>
    hide @bet_buttons
    hide @deal_button
    show @action_buttons
  
  finished: =>
    disable @action_buttons
    show @continue_button
  
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
