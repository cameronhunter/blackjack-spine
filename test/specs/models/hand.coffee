require = window.require

describe 'Hand', ->
  Player = require('models/player')
  Hand = require('models/hand')
  hand = null
  owner = new Player
  
  ace_of_spades = {name:'ace', suit:'spades'}
  ace_of_hearts = {name:'ace', suit:'hearts'}
  ace_of_diamonds = {name:'ace', suit:'diamonds'}
  four_of_spades = {name:4, suit:'spades'}
  queen_of_hearts = {name:'queen', suit:'hearts'}
  king_of_clubs = {name:'king', suit:'clubs'}
  
  beforeEach ->
    hand = new Hand( owner, four_of_spades, queen_of_hearts )
  
  it 'should have an owner', ->
    expect( -> new Hand ).toThrow()
    
  it 'should be dealt two cards', ->
    expect( hand.size() ).toEqual 2
    expect( -> new Hand( owner ) ).toThrow()
    expect( -> new Hand( owner, ace_of_spades ) ).toThrow()
    expect( -> new Hand( owner, ace_of_spades, queen_of_hearts, king_of_clubs ) ).toThrow()
    
  it 'should allow additional cards to be dealt to the hand', ->
    hand.add ace_of_diamonds
    expect( hand.size() ).toEqual 3
    
  it 'should be able to calculate the score', ->
    expect( hand.score() ).toEqual 14
    
  it "aces are valued as either 1 or 11 according to the player's best interest", ->
    awesome_hand = new Hand( owner, ace_of_diamonds, ace_of_spades )
    expect( awesome_hand.score() ).toEqual 12
    awesome_hand.add ace_of_hearts
    expect( awesome_hand.score() ).toEqual 13
  
  it 'should be bust if the value exceeds 21 points', ->
    hand = new Hand( owner, queen_of_hearts, king_of_clubs )
    expect( hand.is_bust() ).toBe false
    hand.add four_of_spades
    expect( hand.is_bust() ).toBe true
  
  it 'should say the hand is blackjack if the score is 21', ->
    hand = new Hand( owner, queen_of_hearts, ace_of_spades )
    expect( hand.is_blackjack() ).toBe true
  
  it "shouldn't deal additional cards to hands which are already bust", ->
    hand = new Hand( owner, queen_of_hearts, king_of_clubs )
    hand.add four_of_spades
    expect( hand.is_bust() ).toBe true
    expect( -> hand.add ace_of_spades ).toThrow()
    
  it "shouldn't deal additional cards to hands which are already blackjack", ->
    hand = new Hand( owner, queen_of_hearts, ace_of_spades )
    expect( hand.is_blackjack() ).toBe true
    expect( -> hand.add king_of_clubs ).toThrow()
