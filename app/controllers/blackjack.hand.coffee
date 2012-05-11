Spine = require('spine')
Cards = require('models/hand')

class Hand extends Spine.Controller

  elements:
    '.hand': 'cards'
    '.score .badge': 'score'

  constructor: ->
    super
    Cards.bind('create change', @render)
    @hand = new Cards
  
  deal: (card) ->
    try
      @hand.add card
    catch e
      # TODO: Either bust or blackjack - should replace the game controls with a deal button

  score: ->
    @hand.score()
  
  template: (cards) ->
    require('views/card')(cards:cards, dealer:true)

  render: =>
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' ).removeClass( 'badge-important' ).removeClass('badge-inverse').addClass( 'badge-warning' )
    else if @hand.is_bust()
      @score.html( 'Bust!' ).removeClass( 'badge-warning' ).removeClass('badge-inverse').addClass( 'badge-important' )
    else
      @score.html( @hand.score() ).removeClass('badge-important').removeClass('badge-warning').addClass('badge-inverse')
        
    @cards.html( @template( @hand.cards ) )
    
module.exports = Hand
