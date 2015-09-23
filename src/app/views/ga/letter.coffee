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
	done: false

	constructor:(@x, @y, @form)->
		@dna = DNA.generate()
		@points = @dna
		@lines = []
		@circles = []
		@MAX_FITNESS = Calc.dist(0,0,70,140) * 5
		@fitness_score = 0

	reset:=>

		@dna = DNA.generate()
		@points = @dna
		@lines = []
		@circles = []
		@MAX_FITNESS = Calc.dist(0,0,70,140) * 5
		@fitness_score = 0
		@done = false

	update:->

		for p, i in @points
			TweenMax.to p, 0.15, x:@dna[i].x, y:@dna[i].y, override:true

	draw:=>

		Draw.CTX.strokeStyle = '#fff'
		Draw.CTX.lineWidth = 2
		Draw.CTX.fillStyle = '#fff'

		for point, i in @points

			if i > 0 and i < @points.length - 2
				prev = @points[i - 1]
				Draw.CTX.beginPath()
				Draw.CTX.lineJoin = "round"
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
				vel *= 1.5

			if dist < 20
				vel *= 2

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

			farther_point = @get_lowest_point()

			if farther_point.dist > 20
				form_el = @form[farther_point.i]
				dist = Calc.dist(form_el.x, form_el.y, @dna[farther_point.i].x, @dna[farther_point.i].y)

				@dna[farther_point.i].x = Math.random() * 70
				@dna[farther_point.i].y = Math.random() * 100

			else
				@done = true

		@fitness_score = 0

	get_lowest_point:=>

		larger_dist = 0
		index = undefined

		for d, i in @dna

			dist = Calc.dist(@form[i].x, @form[i].y, d.x, d.y)
			if dist > larger_dist
				larger_dist = dist
				index = i

		return {i:index, dist:larger_dist}









