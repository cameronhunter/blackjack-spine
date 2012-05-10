Spine = require('spine')
Cards = require('models/hand')

class Hand extends Spine.Controller

  constructor: ->
    super
    @log 'New hand on element', @el
    @hand = new Cards
    @hand.bind('change', @render)
  
  deal: (card) ->
    @hand.add card

  template: (cards) ->
    require('views/card')(cards:cards)

  render: =>
    @html( @template( @hand.cards ) )
    
module.exports = Hand
