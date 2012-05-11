Spine = require('spine')
Cards = require('models/hand')

class Hand extends Spine.Controller

  elements:
    '.badge': 'score'
    '.hand': 'cards'

  constructor: ->
    super
    Cards.bind('create change', @render)
    @hand = new Cards
  
  deal: (card) ->
    @hand.add card

  template: (cards) ->
    require('views/card')(cards:cards, dealer:true)

  render: =>
    @score.html( @hand.score() )
    @cards.html( @template( @hand.cards ) )
    
module.exports = Hand
