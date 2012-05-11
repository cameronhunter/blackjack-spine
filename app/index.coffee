require('lib/setup')

Spine = require('spine')
Player = require('models/player')
Round = require('controllers/blackjack.round')

class App extends Spine.Controller

  DEFAULT_INITIAL_POT_SIZE = 500

  elements:
    '.bank .value': 'bank_value'

  events:
    'click .surrender': 'start'

  constructor: ->
    super
    Player.bind('create change', @render)
    @player = new Player DEFAULT_INITIAL_POT_SIZE
    @start()
  
  start: ->
    @round = new Round(el:$('body'), player:@player)
  
  render: =>
    @bank_value.html( @player.pot.size )

module.exports = App
    
