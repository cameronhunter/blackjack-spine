require('lib/setup')

Spine = require('spine')
Player = require('models/player')
Round = require('controllers/blackjack.round')

class App extends Spine.Controller

  elements:
    '.bank .value': 'bank_value'

  events:
    'click .deal': 'deal'

  constructor: ->
    super
    @log "Create new blackjack on element", @el
    @dealer = new Player
    @player = new Player
    
    @player.bind("change", @render)
    @render()
  
  deal: ->
    @round = new Round(el:$('body'), dealer:@dealer, player:@player)
  
  render: =>
    @bank_value.html( @player.pot.size )

module.exports = App
    
