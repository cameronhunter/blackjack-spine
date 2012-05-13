Spine = require('spine')

class Hand extends Spine.Model
  @configure 'Hand'

  BLACKJACK = 21
  ROYAL_SCORE = 10
  ACE_LOW_SCORE = 1
  ACE_HIGH_SCORE = 11
  ACE = 'A'
  ROYALTY = ['J', 'Q', 'K']

  constructor: (attrs) ->
    @cards = attrs?.cards ? []
    @opponent = attrs?.opponent
  
  size: -> @cards.length
  
  is_bust: ->
    @score() > BLACKJACK
  
  is_blackjack: ->
    @score() == BLACKJACK

  add: (card) -> 
    throw "Hand is already bust. #{card.name for card in @cards}" if @is_bust()
    throw "Hand is already blackjack. #{card.name for card in @cards}" if @is_blackjack()
    card.hidden = @cards.length > 0 and @opponent
    @cards.push( adapt card )
    @save()

  reveal: ->
    (card.hidden = false) for card in @cards
    @save()

  score: ->
    total = 0; aces = 0
    for card in @cards when !card.hidden
      score = score_of card
      total += score
      aces += 1 if score == ACE_HIGH_SCORE
    while total > BLACKJACK and aces > 0
      total -= (ACE_HIGH_SCORE - ACE_LOW_SCORE)
      aces -= 1
    return total

  # Private

  score_of = (card) ->
    return ACE_HIGH_SCORE if card.name is ACE
    return ROYAL_SCORE if card.name in ROYALTY
    return card.name
  
  # node-shuffle cards aren't quite what we want -- adapt them to something more appropriate
  
  adapt = (card) ->
    {suit: suit_name(card), name: card_name(card), hidden: card.hidden}
  
  suit_name = (card) ->
    switch card.suit.toLowerCase()
      when 'heart' then '♥'
      when 'diamond' then '♦'
      when 'spade' then '♠'
      when 'club' then '♣'
  
  card_name = (card) ->
    if 1 < card.sort <= 10 then card.sort else card.description.toUpperCase().substring(0,1)
  
module.exports = Hand
