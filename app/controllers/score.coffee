Spine = require('spine')

class Score extends Spine.Controller
  
  elements:
    '.value': 'score'
  
  constructor: ->
    super
    @hand.bind 'change', @update_score
  
  update_score: =>
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' )
    else if @hand.is_bust()
      @score.html( 'Bust!' )
    else
      @score.html( @hand.score() )
    
module.exports = Score
