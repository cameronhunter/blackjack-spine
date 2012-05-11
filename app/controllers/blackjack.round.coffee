Spine = require('spine')
Pot = require('models/pot')
Cards = require('models/hand')
Deck = require('shuffle/lib')
Hand = require('controllers/blackjack.hand')
$ = Spine.$

class Round extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'
    '.player': 'players_hand'
    '.dealer': 'dealers_hand'

  events:
    'click .bet': 'bet'
    'click .hit': 'hit_me'
    'click .stand': 'stand'

  constructor: ->
    super
    Pot.bind('change', @update_pot)
    Pot.bind('change', @update_winnings)
    @pot = new Pot
    @deck = Deck.shuffle()
    @player_hand = new Hand(el:@players_hand)
    @dealer_hand = new Hand(el:@dealers_hand, opponent:yes)
    @pay @blinds
    @deal()

  deal: ->
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
  
  hit_me: ->
    @hit @player_hand
    
  hit: (hand) ->
    hand.deal @deck.draw()
  
  bet: (e) ->
    @pay $(e.target).data('amount')

  stand: ->
    @hit @dealer_hand # disable the hit/bet/surrender button
  
  pay: (amount) ->
    @player.bets amount
    @pot.credit amount

  update_pot: =>
    @pot_value.html( @pot.size )
  
  update_winnings: =>
    @win_value.html( (@pot.size * @odds).toFixed(2) )
    
module.exports = Round
