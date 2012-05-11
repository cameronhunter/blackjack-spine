require = window.require

describe 'Pot', ->
  Pot = require('models/pot')
  initial_pot_size = 1000
  pot = null
  
  beforeEach ->
    pot = new Pot initial_pot_size

  it 'should allow a pot to be started with an amount', ->
    pot = new Pot 1000
    expect( pot.size ).toEqual 1000

  it 'should allow pots to start empty', ->
    pot = new Pot 0
    expect( pot.size ).toEqual 0
    
  it "shouldn't allow a pot to start with less than 0", ->
    expect( -> new Pot -500 ).toThrow()

  it 'should be able to receive credit', ->
    pot.credit 500
    expect( pot.size ).toEqual initial_pot_size + 500
  
  it 'should only accept positive credits', ->
    expect( -> pot.credit -500 ).toThrow()
    expect( pot.size ).toEqual initial_pot_size
    
  it 'should be able to accept debits', ->
    pot.debit initial_pot_size
    expect( pot.size ).toEqual 0
    
  it 'should only accept positive debits', ->
    expect( -> pot.debit -500 ).toThrow()
    expect( pot.size ).toEqual initial_pot_size
    
  it 'should not accept debits larger than the pot size', ->
    expect( -> pot.debit initial_pot_size * 2 ).toThrow()
    expect( pot.size ).toEqual initial_pot_size
    
  it "shouldn't allow a negative amount in the pot", ->
    pot.size = -500
    expect( pot.isValid() ).toEqual false
    expect( pot.save() ).toEqual false
