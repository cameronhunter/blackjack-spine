require('lib/setup')

Spine = require('spine')
Player = require('models/player')
Bank = require('controllers/bank')
Round = require('controllers/round')

class App extends Spine.Controller

  ODDS = 3/2
  MAX_BET = 100
  DEFAULT_BLINDS = 5
  DEFAULT_INITIAL_POT_SIZE = 500

  elements:
    '.blackjack-table': 'table'

  events:
    'click .surrender': 'restart'

  constructor: ->
    super
    @player = new Player DEFAULT_INITIAL_POT_SIZE
    @start()
  
  start: =>
    @round = new Round(odds: ODDS, max_bet: MAX_BET, blinds:DEFAULT_BLINDS, player:@player)
    @table.html @round.el

  restart: ->
    @round.release()
    @start()
  
module.exports = App
    
