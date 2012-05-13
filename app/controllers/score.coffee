Spine = require('spine')

class Score extends Spine.Controller
  className: 'score row'
  
  elements:
    '.label': 'label'
    '.value': 'score'
  
  constructor: ->
    super
    @html require('views/score')(name:@name)
    @hand.bind 'change', @update_score
  
  update_score: =>
    @label.removeClass 'label-info label-warning label-important'
    if @hand.is_blackjack()
      @score.html( 'Blackjack!' )
      @label.addClass 'label-warning'
      @hand.trigger 'blackjack'
    else if @hand.is_bust()
      @score.html( 'Bust!' )
      @label.addClass 'label-important'
      @hand.trigger 'bust'
    else
      @score.html( @hand.score() )
      @label.addClass 'label-info'
    
module.exports = Score
