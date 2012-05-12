Spine = require('spine')
HandOfCards = require('models/hand')

class Hand extends Spine.Controller
  
  elements:
    '.cards': 'cards'
    '.score': 'score'
  
  constructor: ->
    super
    @html require('views/cards')(name:@name)
    @hand = new HandOfCards(opponent:@opponent)
    @hand.bind 'change', @render
  
  deal: (card) ->
    try
      @hand.add card
      @hand.save()
    catch e
      # Foo

  reveal: ->
    card.hidden = no for card in @hand.cards
    @hand.save()

  render: =>
    @cards.html @template(@hand.cards)
    @score.html @hand.score()
    
  template: (cards) =>
    require('views/card')(cards:cards)
    
module.exports = Hand
