Spine = require('spine')
Score = require('controllers/score')

class Hand extends Spine.Controller
  tag: 'section', className: 'hand'
  
  elements:
    '.cards': 'cards'
  
  constructor: ->
    super
    @el.addClass @name
    @html require('views/hand')()
    
    score = new Score(name:@name, hand:@hand)
    if @score_on_top then @prepend score else @append score
    
    @hand.bind 'change', @update_cards
      
  update_cards: =>
    @cards.html @template(@hand.cards)
      
  template: (cards) =>
    require('views/card')(cards:cards)
    
module.exports = Hand
