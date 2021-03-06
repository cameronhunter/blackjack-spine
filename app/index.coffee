require('lib/setup')

Spine = require('spine')
Pot = require('models/pot')
Player = require('models/player')
Round = require('controllers/round')

class App extends Spine.Controller

  ODDS = 3/2
  MAX_BET = 100
  BLINDS = 5
  POT_SEED = 0
  PLAYER_POT_SIZE = 500

  elements:
    '.blackjack-table': 'table'

  events:
    'click .surrender': 'restart'
    'click .continue': 'restart'

  constructor: ->
    super
    @player = new Player(pot: new Pot PLAYER_POT_SIZE)
    @start()

  start: =>
    @round = new Round(odds:ODDS, pot_size:POT_SEED, max_bet:MAX_BET, blinds:BLINDS, player:@player)
    @table.html @round.el

  restart: =>
    @round.release()
    @start()

module.exports = App

