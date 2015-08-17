DNA = require "./dna"
Calc = require "draw/math/calc"
_ = require "underscore"

module.exports = class Letter

  dna: undefined
  points: undefined
  MAX_FITNESS: undefined
  fitness_score: undefined
  el: undefined
  hit_area: undefined

  constructor:(@two, @x, @y, @form)->
    @dna = DNA.generate()
    @points = []
    @children = []
    @el = @two.makeGroup()
    @MAX_FITNESS = Calc.dist(0,0,70,140) * 5
    @fitness_score = 0
    @hit_area = @two.makeRectangle(0,0,70,140)
    @el.add(@hit_area)
    @hit_area.opacity = 0
    @el.translation.set(@x,@y)

    @draw()

  update:->

  draw:=>

    @el.remove(@children)

    for point, i in @dna
      circle = @two.makeCircle point.x, point.y, 2
      circle.fill = '#FF8800'
      circle.noStroke()
      @el.add circle
      @children.push circle

      if i > 0 and i < @dna.length - 2
        prev = @dna[i - 1]
        line = @two.makeLine prev.x, prev.y, point.x, point.y
        @children.push line
        @el.add line

      if i > @dna.length - 2
        prev = @dna[i - 1]
        line = @two.makeLine prev.x, prev.y, point.x, point.y
        @children.push line
        @el.add line

  fitness:=>

    count = 0

    for p, i in @dna
      dist = Calc.dist @form[i].x, @form[i].y, p.x, p.y
      vel = 15 - (dist / 10)

      if dist < 30
        vel *= 2

      if dist < 20
        vel *= 3

      if dist < 10
        vel *= 5

      if dist < 5
        vel *= 8

      if dist > 50
        vel *= 0.1

      count += vel

    @fitness_score = count
    @fitness_score

  evolve:(new_dna, index)=>

    @dna = _.clone(new_dna)

    if (Math.random() * 10) < 0.1
      rnd_pos = Math.floor(Math.abs(Math.random() * @dna.length - 1))
      form_el = @form[rnd_pos]
      dist = Calc.dist(form_el.x, form_el.y, @dna[rnd_pos].x, @dna[rnd_pos].y)

      if dist > 50
        @dna[rnd_pos].x = Math.random() * 70
        @dna[rnd_pos].y = Math.random() * 140

      else if dist > 30
        @dna[rnd_pos].x = (@dna[rnd_pos].x - (Math.random() * 10)) + Math.random() * 10;
        @dna[rnd_pos].y = (@dna[rnd_pos].y - (Math.random() * 10)) + Math.random() * 10;

    @fitness_score = 0








