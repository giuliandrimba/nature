AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
alphabet = require "./alphabet"
Letter = require "./letter"

module.exports = class Index extends AppView

  letters: []
  TOTAL_LETTERS: 40
  mating_pool: []
  counter: 0


  destroy:->
    super

  after_render:=>

    params =
      width: $(window).width()
      height: $(window).height()

    @two = new Two(params).appendTo @el.find(".lab").get(0)

    @total = $(window).width() / 120
    @line = 0
    @column = 0

    @A = new Letter @two, 0, 20, alphabet.A
    @A.dna = alphabet.A
    # @A.draw()

    i = 0

    while i < @TOTAL_LETTERS

      l = new Letter @two, @column * 120, @line * 120, alphabet.A
      @column++

      if @column > @total
        @line++
        @column = 0

      @letters.push l

      i++

    @two.bind("update", @update).play()
    $("body").bind "mousedown", @evolve

  update:=>

  selection:=>

    @mating_pool = []

    for letter in @letters
      letter.fitness()

    for letter in @letters
      fit = Math.abs(Math.floor(letter.fitness_score))
      j = 0
      while j < fit
        @mating_pool.push letter.dna
        j++

  reproduce:=>

  evolve:=>

    @selection()

    for letter, i in @letters
      rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
      dna_A = @mating_pool[rnd_dna]
      rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
      dna_B = @mating_pool[rnd_dna]

      new_dna = @crossover dna_A, dna_B

      if new_dna
        letter.evolve new_dna, i
        letter.draw()

    @selection()

  crossover:(a, b)=>

    new_dna = []
    parents = [a,b]

    i = 0
    while i < alphabet.A.length

      dist_a = Calc.dist a[i].x, a[i].y, alphabet.A[i].x, alphabet.A[i].y
      dist_b = Calc.dist b[i].x, b[i].y, alphabet.A[i].x, alphabet.A[i].y
      index = Math.floor(Math.random() * 2)

      if dist_a < 10
        index = 0
      else if dist_b < 10
        index = 1
      else if (dist_a < dist_b && dist_b < 10 && dist_a < 10)
        index = 0

      new_dna.push parents[index][i]

      i++

    new_dna




