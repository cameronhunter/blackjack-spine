require = window.require

describe 'Player', ->
  Player = require('models/player')

  it 'should own a pot', ->
    player = new Player
    expect( player.pot.size ).toEqual 500    
