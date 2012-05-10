Spine = require('spine')
Pot = require('models/pot')
Deck = require('shuffle/lib')
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
    @pot = new Pot 0
    @deck = Deck.shuffle()
    @player_hand = new Hand(el:$('.player.hand'))
    @dealer_hand = new Hand(el:$('.dealer.hand'))
    @pot.bind("change", @render)
    @deal()

  deal: ->
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
  
  bet: ->
    amount = 50
    @player.bets amount
    @pot.credit amount

  render: =>
    @pot_value.html( @pot.size )
    
module.exports = Round
