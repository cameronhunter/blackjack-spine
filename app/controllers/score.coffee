Spine = require('spine')

class Score extends Spine.Controller
  
  elements:
    '.value': 'score'
  
  constructor: ->
    super
    @hand.bind 'change', @update_score
  
  update_score: =>
    @el.removeClass 'label-info label-warning label-important'
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' )
      @el.addClass 'label-warning'
      @hand.trigger 'blackjack'
    else if @hand.is_bust()
      @score.html( 'Bust!' )
      @el.addClass 'label-important'
      @hand.trigger 'bust'
    else
      @score.html( @hand.score() )
      @el.addClass 'label-info'
    
module.exports = Score
