Spine = require('spine')

class Pot extends Spine.Model
  @configure 'Pot', 'size'
  
  DEFAULT_SIZE = 500
  
  constructor: (amount) -> 
    throw "We're not in the credit business here" if amount < 0
    @size =
      if amount >= 0
        amount
      else
        DEFAULT_SIZE

  validate: -> "We're card sharks, not loan sharks!" unless @size >= 0
  
  credit: (amount) ->
    throw "Can only credit positive amounts. Got: #{amount}" if amount < 0
    @size += amount
  
  debit: (amount) ->
    throw "Can only debit positive amounts. Got: #{amount}" if amount < 0
    throw "You can't debit #{amount}, there's only #{@size} in the pot" if amount > @size
    @size -= amount
  
module.exports = Pot
