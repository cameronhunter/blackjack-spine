require('lib/setup')

Spine = require('spine')
Blackjack = require('controllers/blackjack')

class App extends Spine.Controller
  constructor: ->
    super
    @game = new Blackjack(el:@el)

module.exports = App
    
