Spine = require('spine')
List = require('spine/lib/list')
Player = require('models/player')
$ = Spine.$

class Blackjack extends Spine.Controller
  tag: 'body'

  events:
    'click .deal': 'deal'
  
  constructor: ->
    super

  deal: (event) ->
    console.log "woot"
    
module.exports = Blackjack
