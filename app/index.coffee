require('lib/setup')

Spine = require('spine')
Player = require('models/player')
Hand = require('controllers/blackjack.hand')
Round = require('controllers/blackjack.round')

class App extends Spine.Controller

  # TODO Implement odds for winnings

  DEFAULT_BLINDS = 5
  DEFAULT_INITIAL_POT_SIZE = 500

  elements:
    '.bank .value': 'bank_value'

  events:
    'click .surrender': 'start'

  constructor: ->
    super
    Player.bind('create change', @update_players_pot)
    @player = new Player DEFAULT_INITIAL_POT_SIZE
    @start()
  
  start: ->
    @round = new Round(el:@el, player:@player, blinds:DEFAULT_BLINDS)
  
  update_players_pot: =>
    @bank_value.html( @player.pot.size )

module.exports = App
    
