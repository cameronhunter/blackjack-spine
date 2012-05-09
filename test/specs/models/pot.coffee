require = window.require

describe 'Pot', ->
  Pot = require('models/pot')
  pot = null
  
  beforeEach ->
    pot = new Pot

  it 'should start with 500 credits by default', ->
    expect( pot.size ).toEqual 500

  it 'should be able to receive credit', ->
    pot.credit 500
    expect( pot.size ).toEqual 1000
  
  it 'should only accept positive credits', ->
    pot.credit -500
    expect( pot.size ).toEqual 500
    
  it 'should be able to accept debits', ->
    pot.debit 500
    expect( pot.size ).toEqual 0
    
  it 'should only accept positive debits', ->
    pot.debit -500
    expect( pot.size ).toEqual 500
    
  it 'should not accept debits larger than the pot size', ->
    pot.debit 1000
    expect( pot.size ).toEqual 500
    
  it "shouldn't allow a negative amount in the pot", ->
    pot.size = -500
    expect( pot.save() ).toEqual false
