Spine = require('spine')

class Pot extends Spine.Model
  @configure 'Pot', 'size'
  
  constructor: ->
    @size = 500
  
  credit: (amount) ->
    throw "Can only credit positive amounts. Got: #{amount}" if amount < 0
    @size += amount
  
  debit: (amount) ->
    throw "Can only debit positive amounts. Got: #{amount}" if amount < 0
    throw "You can't debit #{amount}, there's only #{@size} in the pot." if amount > @size
    @size -= amount
  
  validate: ->
    "You're broke!" unless @size > 0
  
module.exports = Pot
