Spine = require('spine')

class Pot extends Spine.Model
  @configure 'Pot', 'size'
  
  constructor: (amount, odds = 1) -> 
    throw "We're not in the credit business here" if amount < 0
    @size = amount ? 0
    @odds = odds

  validate: ->
    "We're card sharks, not loan sharks!" unless @size >= 0
  
  winnings: ->
    @size * @odds
  
  credit: (amount) ->
    throw "Can only credit positive amounts. Got: #{amount}" if amount < 0
    @size += amount
    @save()
  
  debit: (amount) ->
    throw "Can only debit positive amounts. Got: #{amount}" if amount < 0
    throw "You can't debit #{amount}, there's only #{@size} in the pot" if amount > @size
    @size -= amount
    @save()

module.exports = Pot
