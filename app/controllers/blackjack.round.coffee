Spine = require('spine')
Pot = require('models/pot')
Deck = require('shuffle/lib')
Hand = require('controllers/blackjack.hand')
$ = Spine.$

class Round extends Spine.Controller

  elements:
    '.pot .value': 'pot_value'
    '.win .value': 'win_value'
    '.player': 'players_hand'
    '.dealer': 'dealers_hand'
    '.controls': 'play_buttons'
    '.deal': 'deal_button'

  events:
    'click .bet': 'bet'
    'click .hit': 'hit_me'
    'click .stand': 'stand'
    'bust': 'outcome'
    'blackjack': 'outcome'

  constructor: ->
    super
    Pot.bind('change', @update_pot)
    Pot.bind('change', @update_winnings)
    @pot = new Pot 10
    @deck = Deck.shuffle()
    @player_hand = new Hand(el:@players_hand)
    @dealer_hand = new Hand(el:@dealers_hand, opponent:yes)
    @deal()

  deal: ->
    @pay @blinds
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @player_hand.deal @deck.draw()
    @dealer_hand.deal @deck.draw()
    @play_buttons.show()
  
  hit_me: ->
    @hit @player_hand
    
  hit: (hand) ->
    hand.deal @deck.draw()
  
  bet: (e) ->
    @pay $(e.target).data('amount')
    
  stand: ->
    @hit @dealer_hand # disable the hit/bet/surrender button

  outcome: (e) ->
    @play_buttons.hide()
    if e.type is 'blackjack'
      @earn @pot.size * @odds

  earn: (amount) ->
    @player.wins amount
    @pot.debit amount

  pay: (amount) ->
    @player.bets amount
    @pot.credit amount

  update_pot: =>
    @pot_value.html( @pot.size.toFixed(2) )
  
  update_winnings: =>
    @win_value.html( (@pot.size * @odds).toFixed(2) )
    
module.exports = Round
