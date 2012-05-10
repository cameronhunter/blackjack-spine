require('spine/lib/relation')

Spine = require('spine')

class Hand extends Spine.Model
  @configure 'Hand'
  @hasOne 'owner', 'models/person'

  BLACKJACK = 21
  ROYAL_SCORE = 10
  ACE_LOW_SCORE = 1
  ACE_HIGH_SCORE = 11
  
  constructor: (owner, cards...) ->
    throw 'Hands require owners' unless owner
    throw 'Hands should be dealt with two cards' unless cards.length == 2
    @owner = owner
    @cards = cards

  size: -> @cards.length
  
  is_bust: -> @score() > BLACKJACK
  
  is_blackjack: -> @score() == BLACKJACK

  add: (card) -> 
    throw "Hand is already bust" if @is_bust()
    throw "Hand is already blackjack" if @is_blackjack()
    @cards.push card

  score: ->
    total = 0; aces = 0
    for card in @cards
      score = score_of card
      total += score
      aces += 1 if score == ACE_HIGH_SCORE
    while total > BLACKJACK and aces > 0
      total -= (ACE_HIGH_SCORE - ACE_LOW_SCORE)
      aces -= 1
    return total

  # Private
  
  score_of = (card) ->
    return ACE_HIGH_SCORE if is_ace card
    return ROYAL_SCORE if is_royalty card
    return card.name
  
  is_ace = (card) -> card.name is 'ace'
  is_royalty = (card) -> card.name in ['jack', 'queen', 'king']
    
module.exports = Hand
