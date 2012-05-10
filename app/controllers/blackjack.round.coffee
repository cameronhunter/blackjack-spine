Spine = require('spine')
Pot = require('models/pot')
Hand = require('controllers/blackjack.hand')
$ = Spine.$

class Round extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.bet': 'bet_button'

  events:
    'click .bet': 'bet'

  constructor: ->
    super
    @log 'New round on element', @el
    @pot = new Pot 0
    player_hand = new Hand(el:$('.player.hand'))
    dealer_hand = new Hand(el:$('.dealer.hand'))
    
    @pot.bind("change", @render)

  bet: ->
    amount = 50
    @log 'Betting', amount
    
    @player.bets amount
    @pot.credit amount

  render: =>
    @pot_value.html( @pot.size )
    
module.exports = Round
