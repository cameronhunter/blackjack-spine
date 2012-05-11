require = window.require

describe 'Player', ->
  Player = require('models/player')
  initial_pot_size = 1000
  player = null
  
  beforeEach ->
    player = new Player initial_pot_size

  it 'should own a pot', ->
    expect( player.pot ).toBeDefined()
    expect( player.pot.size ).toEqual initial_pot_size
  
  it "should add money to the player's pot when they win", ->
    player.wins 500
    expect( player.pot.size ).toEqual initial_pot_size + 500
  
  it 'should be able to bet an amount of their pot', ->
    player.bets 300
    expect( player.pot.size ).toEqual initial_pot_size - 300
  
  it 'should not be able to bet more than they own', ->
    expect( -> player.bets initial_pot_size * 2 ).toThrow()
    expect( player.pot.size ).toEqual initial_pot_size
  
  it 'should be able to check if they can bet that amount', ->
    expect( player.can_afford initial_pot_size ).toBe true
    expect( player.can_afford initial_pot_size * 2 ).toBe false
