Spine = require('spine')

class Pot extends Spine.Model
  @configure 'Pot', 'size'
  
  constructor: ->
    @size = 500
  
  credit: (amount) ->
    return "Can only credit positive amounts. Got: #{amount}" if amount < 0
    @size += amount
  
  debit: (amount) ->
    return "Can only debit positive amounts. Got: #{amount}" if amount < 0
    return "You can't debit #{amount}, you've only got #{@size} in the pot." if amount > @size
    @size -= amount
  
  validate: ->
    return "You're broke!" unless @size > 0
  
module.exports = Pot
