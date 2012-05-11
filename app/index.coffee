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
    'section.bank': 'bank_section'

  events:
    'click .surrender': 'start'

  constructor: ->
    super
    @player = new Player DEFAULT_INITIAL_POT_SIZE
    @bank = new Bank(el: @bank_section, player:@player)
    @start()
  
  start: ->
    @round = new Round(odds: ODDS, max_bet: MAX_BET, blinds:DEFAULT_BLINDS, player:@player, el:@el)
  
module.exports = App
    
