Spine = require('spine')
Deck = require('shuffle/lib')
Pot = require('controllers/pot')
Hand = require('controllers/hand')
Actions = require('controllers/actions')
$ = Spine.$

class Round extends Spine.Controller

  elements:
    'section.player': 'players_section'
    'section.dealer': 'dealers_section'
    'section.pot': 'pot_section'
    '.actions': 'actions_section'

  events:
    'click .deal': 'deal'
    'click .bet': 'bet'
    'click .hit': 'hit_me'
    'click .stand': 'stand'

  constructor: ->
    super
    @deck = Deck.shuffle()

    @pot = new Pot(el:@pot_section, odds:@odds)
    @players_hand = new Hand(el:@players_section, name:'player')
    @dealers_hand = new Hand(el:@dealers_section, name:'dealer', opponent:yes)
    @actions = new Actions(el:@actions_section)
    
    @pay_into_pot @blinds

  deal: ->
    @hit @players_hand
    @hit @dealers_hand
    @hit @players_hand
    @hit @dealers_hand
  
  bet: (e) ->
    @pay_into_pot $(e.target).data('amount')

  hit: (hand) ->
    hand.deal @deck.draw()
    
  stand: ->
    #@hit @dealers_hand # disable the hit/bet/surrender button

  outcome: (e) ->
    @play_buttons.hide()
    if e.type is 'blackjack'
      @pay_into_bank @pot.winnings()

  hit_me: ->
    @hit @players_hand

  pay_into_bank: (amount) ->
    @player.wins amount

  pay_into_pot: (amount) ->
    @player.bets amount
    @pot.add amount

module.exports = Round
