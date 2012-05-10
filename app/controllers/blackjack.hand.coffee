Spine = require('spine')

class Hand extends Spine.Controller

  constructor: ->
    super
    @log 'New hand on element', @el
    
module.exports = Hand
