Spine = require('spine')
Cards = require('models/hand')

class Hand extends Spine.Controller

  elements:
    '.hand': 'cards'
    '.score .badge': 'score'

  constructor: ->
    super
    Cards.bind('change', @render)
    @hand = new Cards(opponent:@opponent)
  
  deal: (card) ->
    try
      @hand.add card
    catch e
      # TODO: Either bust or blackjack - should replace the game controls with a deal button

  template: (cards) ->
    require('views/card')(cards:cards)

  # Argh - this is horrible
  render: =>
    state = 'badge-important badge-inverse badge-warning'
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' ).removeClass( state ).addClass( 'badge-warning' )
    else if @hand.is_bust()
      @score.html( 'Bust!' ).removeClass( state ).addClass( 'badge-important' )
    else
      @score.html( @hand.score() ).removeClass( state ).addClass('badge-inverse')
        
    @cards.html( @template( @hand.cards ) )
    
module.exports = Hand
