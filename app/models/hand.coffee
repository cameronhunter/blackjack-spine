Spine = require('spine')

class Hand extends Spine.Model
  @configure 'Hand'

  BLACKJACK = 21
  ROYAL_SCORE = 10
  ACE_LOW_SCORE = 1
  ACE_HIGH_SCORE = 11
  ACE = 'A'
  ROYALTY = ['J', 'Q', 'K']
  
  constructor: (cards...) ->
    @cards = (adapt(card) for card in cards)

  size: -> @cards.length
  
  is_bust: -> @score() > BLACKJACK
  
  is_blackjack: -> @score() == BLACKJACK

  add: (card) -> 
    throw "Hand is already bust. #{card.name for card in @cards}" if @is_bust()
    throw "Hand is already blackjack. #{card.name for card in @cards}" if @is_blackjack()
    @cards.push( adapt card )
    @save()

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
  
  adapt = (card) ->
    {suit: suit_name(card), name: card_name(card)}
  
  suit_name = (card) ->
    "#{card.suit?.toLowerCase()}s"
  
  card_name = (card) ->
    name = card.description?.toUpperCase()[0]
    return name if name is ACE or name in ROYALTY
    return card.sort
  
  score_of = (card) ->
    return ACE_HIGH_SCORE if card.name is ACE
    return ROYAL_SCORE if card.name in ROYALTY
    return card.name
    
module.exports = Hand
