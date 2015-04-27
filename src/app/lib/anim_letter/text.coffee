AnimLetter = require "app/lib/anim_letter/letter"

class AnimText

  numbers = [0,1,2,3,4,5,6,7,8,9]
  text_letters = []
  current : 0
  total : 0
  _added = false

  constructor:(dom, delay = 0)->
    @delay = delay
    @text = dom
    @_init()

  _init:=>
    @anim_letters = []
    @current = 0

    for letter in @text.text()
      @anim_letters.push new AnimLetter(letter, @text)

    @total = @anim_letters.length

  start:->
    @text.css("opacity", 0)
    setTimeout (=>
      @text.css("opacity", 1)
      @tween(true)
    ), @delay

  tween:(init)->
    @anim_letters[@current].tween(10, init).on_complete = =>
      @current++
      if @current < @total
        @tween()
        return

module.exports = AnimText
