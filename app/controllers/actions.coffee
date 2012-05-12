Spine = require('spine')

class Actions extends Spine.Controller

  elements:
    '.bet': 'bet_buttons'
    '.action': 'action_buttons'

  events:
    'click .deal': 'deal'

  constructor: ->
    super
    Spine.bind 'winner', => disable @action_buttons
    @setup()
  
  setup: =>
    show @bet_buttons
    hide @action_buttons
  
  deal: ->
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
