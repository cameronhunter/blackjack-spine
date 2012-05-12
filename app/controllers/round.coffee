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
    'section.player': 'players_section'
    'section.dealer': 'dealers_section'
    'section.pot': 'pot_section'
    'section.actions': 'actions_section'
    '.player .bank': 'bank_section'
    '.player .score': 'players_score'
    '.dealer .score': 'dealers_score'
  
  events:
    'click .deal': 'deal'
    'click .bet': 'bet'
    'click .hit': 'hit_me'
    'click .stand': 'stand'

  constructor: ->
    super
    @html require('views/round')()
    
    @deck = Deck.shuffle()
    
    @pot = new Pot(0, @odds)
    @players_hand = new Cards
    @dealers_hand = new Cards(opponent:yes)
    
    new Hand(el:@dealers_section, hand:@dealers_hand)
    new Hand(el:@players_section, hand:@players_hand)
    
    new Score(hand:@players_hand, el:@players_score)
    new Score(hand:@dealers_hand, el:@dealers_score)

    new MoneyPot(el:@pot_section, pot:@pot)
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
      @hit @dealers_hand # disable the hit/bet/surrender button
      @stand()
    else
      @outcome()

  outcome: =>
    if @players_hand.is_bust()
      @log 'You lose', @players_hand.score(), @dealers_hand.score()
      return
      
    if @dealers_hand.is_bust() or @players_hand.score() > @dealers_hand.score()
      @log 'Winner winner chicken dinner', @players_hand.score(), @dealers_hand.score()
      @pay_into_bank @pot.winnings()
      return

    @log 'Push', @players_hand.score(), @dealers_hand.score()

  hit_me: ->
    @hit @players_hand

  pay_into_bank: (amount) ->
    @player.wins amount

  pay_into_pot: (amount) ->
    @player.bets amount
    @pot.credit amount
    @player.save()
    @pot.save()

module.exports = Round
