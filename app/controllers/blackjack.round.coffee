Spine = require('spine')
Pot = require('models/pot')
Deck = require('shuffle/lib')
Hand = require('controllers/blackjack.hand')
$ = Spine.$

class Round extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.bet': 'bet_button'
    '.player': 'players_hand'
    '.dealer': 'dealers_hand'

  events:
    'click .bet': 'bet_action'
    'click .hit': 'hit'

  constructor: ->
    super
    Pot.bind("create change", @update_pot)
    @pot = new Pot 0
    @deck = Deck.shuffle()
    @player_hand = new Hand(el:@players_hand)
    @dealer_hand = new Hand(el:@dealers_hand)
    @deal()

  deal: ->
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @bet 5 # Blinds
  
  hit: ->
    @player_hand.deal @deck.draw()
  
  bet_action: (e) ->
    @bet $(e.target).data('amount')
  
  bet: (amount) ->
    @player.bets amount
    @pot.credit amount

  update_pot: =>
    @pot_value.html( @pot.size )
    
module.exports = Round
