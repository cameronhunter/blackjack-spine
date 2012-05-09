require = window.require

describe 'Pot', ->
  Pot = require('models/pot')

  it 'should start with 500 credits by default', ->
    pot = new Pot
    expect( pot.size ).toEqual 500

  it 'should be able to receive credit', ->
    pot = new Pot
    pot.credit 500
    expect( pot.size ).toEqual 1000
  
  it 'should only accept positive credits', ->
    pot = new Pot
    pot.credit -500
    expect( pot.size ).toEqual 500
    
  it 'should be able to accept debits', ->
    pot = new Pot
    pot.debit 500
    expect( pot.size ).toEqual 0
    
  it 'should only accept positive debits', ->
    pot = new Pot
    pot.debit -500
    expect( pot.size ).toEqual 500
    
  it 'should not accept debits larger than the pot size', ->
    pot = new Pot
    pot.debit 1000
    expect( pot.size ).toEqual 500
