Spine = require('spine')
Deck = require('shuffle/lib')
Pot = require('models/pot')
Cards = require('models/hand')
MoneyPot = require('controllers/pot')
Hand = require('controllers/hand')
Actions = require('controllers/actions')
Score = require('controllers/score')
Bank = require('controllers/bank')
$ = Spine.$

class Round extends Spine.Controller
  
  elements:
    'section.actions': 'actions_section'
    'section.bank': 'bank_section'
  
  events:
    'click .deal': 'deal'
    'click .bet': 'bet'
    'click .hit': 'hit_me'
    'click .stand': 'stand'

  constructor: ->
    super
    @html require('views/round')()
    
    @deck = Deck.shuffle()
    
    @pot = new Pot(@pot_size, @odds)
    @players_hand = new Cards
    @dealers_hand = new Cards(opponent:yes)

    Cards.unbind()
    Cards.bind 'bust', @outcome
    Cards.bind 'blackjack', @outcome
    
    @append new Hand(hand:@dealers_hand, name:'dealer')
    @append new MoneyPot(pot:@pot)
    @append new Hand(hand:@players_hand, name:'player', score_on_top:yes)
    
    new Bank(el:@bank_section)
    new Actions(el:@actions_section)
    
    @pay_into_pot @blinds
    
  deal: ->
    @hit @players_hand
    @hit @dealers_hand
    @hit @players_hand
    @hit @dealers_hand
  
  bet: (e) ->
    @pay_into_pot $(e.target).data('amount')

  hit: (hand) ->
    try hand.add @deck.draw()
    
  stand: ->
    @dealers_hand.reveal()
    if @dealers_hand.score() < 17
      @hit @dealers_hand
      @stand()
    else
      @outcome()

  outcome: =>
    player_score = @players_hand.score()
    dealer_score = @dealers_hand.score()
    
    if player_score == dealer_score
      @draw()
      return

    if @dealers_hand.is_bust() or (!@players_hand.is_bust() and (player_score > dealer_score))
      @win()
      return
      
    @lose()

  win: ->
    Spine.trigger 'result', 'You Win'
    @pay_into_bank @pot.winnings()
    
  draw: ->
    Spine.trigger 'result', 'Draw'
    @pay_into_bank @pot.size - @blinds
    
  lose: ->
    Spine.trigger 'result', 'You Lose'

  hit_me: ->
    @hit @players_hand

  pay_into_bank: (amount) ->
    @player.wins amount

  pay_into_pot: (amount) ->
    @player.bets amount
    @pot.credit amount

module.exports = Round
