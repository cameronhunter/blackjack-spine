Spine = require('spine')
Cards = require('models/hand')

class Hand extends Spine.Controller
  
  elements:
    '.hand': 'cards'
    '.score': 'score'

  constructor: ->
    super
    @hand = new Cards(opponent:@opponent)
    @update()
  
  deal: (card) ->
    try
      @hand.add card
      @update()
    catch e
      # Do something about this

  template: (cards) ->
    require('views/card')(cards:cards)

  update: =>
    @cards.html( @template( @hand.cards ) )
    
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' ).trigger('blackjack')
    else if @hand.is_bust()
      @score.html( 'Bust!' ).trigger('bust')
    else
      @score.html( @hand.score() )
      
module.exports = Hand
