class AnimLetter

  _alphabet : ["|","-","|","-","|","-","|","-","|","-","|","-","|"]
  _iteration : 0
  _delay = 0
  _completed:false

  on_complete : ()->
    #

  constructor:(letter, text)->
    @letter = letter
    @txt = text

  tween:(delay, init)->

    @_delay = delay
    @txt.text("") if init is true
    @txt.text(@txt.text() + @letter)
    @txt_letters = @txt.text().split("")
    @last_pos = @txt_letters.length - 1

    @tick = =>

      if @_iteration >= 1 and !@_completed
        @_completed = true
        @on_complete()

      if @_iteration >= @_alphabet.length
        @change true
        return
      else
        window.requestAnimationFrame @tick

      @change()

    @tick()

    @

  change:(finish=false)->
    @txt_letters = @txt.text().split("")

    if finish
      @txt_letters[@last_pos] = @letter
    else
      @txt_letters[@last_pos] = @_alphabet[ @random_letter() ]

    text = @txt_letters.join("")

    @txt.text(text)
    @_iteration++

  random_letter:->
    rnd = Math.floor((Math.random()*@_alphabet.length)+0);
    rnd

module.exports = AnimLetter
