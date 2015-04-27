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
    @txt_letters[@last_pos] = @letter

    @tick = =>

      window.requestAnimationFrame @tick
      if @_iteration >= 1 and !@_completed
        @_completed = true
        @on_complete()
        window.cancelAnimationFrame @tick

      if @_iteration >= @_alphabet.length
        @txt_letters = @txt.text().split("")
        @txt_letters[@last_pos] = @letter
        @txt.text(@txt_letters.join("").toUpperCase())
        return

      @change()

    @tick()

    @

  change:->
    @txt_letters = @txt.text().split("")
    @txt_letters[@last_pos] = @_alphabet[ @random_letter() ]
    @txt.text(@txt_letters.join("").toUpperCase())
    @_iteration++

  random_letter:->
    rnd = Math.floor((Math.random()*@_alphabet.length)+0);
    rnd

module.exports = AnimLetter
