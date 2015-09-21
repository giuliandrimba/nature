DNA = require "./dna"
Calc = require "draw/math/calc"
Circle = require "draw/geom/circle"
Draw = require "draw/draw"
_ = require "underscore"

module.exports = class Letter

	dna: undefined
	points: undefined
	MAX_FITNESS: undefined
	fitness_score: undefined
	el: undefined
	hit_area: undefined

	constructor:(@x, @y, @form)->
		@dna = DNA.generate()
		@points = @dna
		@lines = []
		@circles = []
		@MAX_FITNESS = Calc.dist(0,0,70,140) * 5
		@fitness_score = 0

		@draw()

	update:->

		for p, i in @points
			TweenMax.to p, 0.25, x:@dna[i].x, y:@dna[i].y, override:true

	draw:=>

		for point, i in @points

	    # Draw.CTX.fillStyle = '#FF8800'
	    # Draw.CTX.beginPath()
	    # Draw.CTX.arc @x + point.x, @y + point.y, 2, 0, Math.PI*2,true
	    # Draw.CTX.closePath()
	    # Draw.CTX.fill()

			Draw.CTX.strokeStyle = '#000'
			Draw.CTX.lineWidth = 1

			if i > 0 and i < @points.length - 2
				prev = @points[i - 1]
				Draw.CTX.beginPath()
				Draw.CTX.moveTo @x + prev.x, @y + prev.y
				Draw.CTX.lineTo @x + point.x, @y + point.y
				Draw.CTX.stroke()

			if i > @points.length - 2
				prev = @points[i - 1]
				Draw.CTX.beginPath()
				Draw.CTX.moveTo @x + prev.x, @y + prev.y
				Draw.CTX.lineTo @x + point.x, @y + point.y
				Draw.CTX.stroke()

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

		if (Math.random() * 10) < 1


			rnd_pos = Math.floor(Math.abs(Math.random() * @dna.length - 1))
			form_el = @form[rnd_pos]
			dist = Calc.dist(form_el.x, form_el.y, @dna[rnd_pos].x, @dna[rnd_pos].y)

			console.log "MUTATE", rnd_pos, dist

			if dist > 50
				@dna[rnd_pos].x = Math.random() * 70
				@dna[rnd_pos].y = Math.random() * 140

			else if dist > 15
				@dna[rnd_pos].x = (@dna[rnd_pos].x - (Math.random() * 50)) + Math.random() * 50;
				@dna[rnd_pos].y = (@dna[rnd_pos].y - (Math.random() * 50)) + Math.random() * 50;
			else
				@dna[rnd_pos].x = (@dna[rnd_pos].x - (Math.random() * 10)) + Math.random() * 10;
				@dna[rnd_pos].y = (@dna[rnd_pos].y - (Math.random() * 10)) + Math.random() * 10;

		@fitness_score = 0








