Spine = require('spine')
HandOfCards = require('models/hand')
Score = require('controllers/score')

class Hand extends Spine.Controller
  
  elements:
    '.cards': 'cards'
  
  constructor: ->
    super
    @hand.bind 'change', @update_cards
      
  update_cards: =>
    @cards.html @template(@hand.cards)
      
  template: (cards) =>
    require('views/card')(cards:cards)
    
module.exports = Hand
