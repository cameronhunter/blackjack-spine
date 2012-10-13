Spine = require('spine')
Player = require('models/player')
$ = Spine.$

class Actions extends Spine.Controller

  elements:
    '.deal': 'deal_button'
    '.continue': 'continue_button'
    '.surrender': 'surrender_button'
    '.bet': 'bet_buttons'
    '.action': 'action_buttons'
    '.start-over': 'start_over_button'

  events:
    'click .deal': 'deal'

  constructor: ->
    super
    @html require('views/actions')()
    Spine.bind 'result', @finished
    Spine.bind 'finish', @can_play
    Player.bind 'change', @bank_check
    @setup()

  setup: =>
    show @bet_buttons
    hide @action_buttons
    hide @continue_button
    hide @start_over_button

  deal: =>
    hide @bet_buttons
    hide @deal_button
    show @action_buttons

  finished: =>
    hide @action_buttons
    show @continue_button

  can_play: =>
    show @start_over_button
    hide @bet_buttons
    hide @deal_button
    hide @continue_button

  bank_check: (player) =>
    for el in @bet_buttons.find('button')
      bet_button = $(el)
      (disable bet_button) if bet_button.data('amount') > player.pot.size

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
