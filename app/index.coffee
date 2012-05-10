require('lib/setup')

Spine = require('spine')
Player = require('models/player')
Round = require('controllers/blackjack.round')

class App extends Spine.Controller

  elements:
    '.bank .value': 'bank_value'

  constructor: ->
    super
    @log "Create new blackjack on element", @el
    @dealer = new Player
    @player = new Player
    @round = new Round(el:$('body'), dealer:@dealer, player:@player)
    
    @player.bind("change", @render)
    @render()
    
  render: =>
    @bank_value.html( @player.pot.size )

module.exports = App
    
