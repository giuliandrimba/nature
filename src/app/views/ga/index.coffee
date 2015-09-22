AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
alphabet = require "./alphabet"
Letter = require "./letter"

module.exports = class Index extends AppView

	destroy:->
		super

	after_render:=>

		@ctx = window.Sketch.create

			container: @el.find(".lab").get(0)
			fullscreen: true
			autoclear:false
			total: 5
			line: 0
			column: 0
			letters: []
			TOTAL_LETTERS: 30
			mating_pool: []
			counter: 0


			setup:->

				Draw.CTX = $(".sketch").get(0).getContext("2d")

				@total = Math.round(@width / 70)
				@TOTAL_LETTERS = Math.round(@height / 140) * @total

				i = 0

				while i < @TOTAL_LETTERS
					l = new Letter (@column * 120), (@line * 170), alphabet.A
					@column++

					if @column > @total
						@line++
						console.log @line
						@column = 0

					index = Math.floor(Math.random() * 3)
					index2 = Math.floor(Math.random() * l.dna.length)
					@letters.push l:l, i: index, i2:index2

					i++

			update:->

			mousedown:->
				@evolve()

			mouseup:->

			draw:->
				Draw.CTX.fillStyle = "rgba(0,0,0,0.1)"
				Draw.CTX.fillRect(0, 0, @width, @height)

				for l, i in @letters
					l.l.draw()

					prev_point = l.l.points[l.i]

					if i > 0
						prev_l = @letters[i - 1]
						point = l.l.points[l.i]

						Draw.CTX.globalAlpha = 0.1
						Draw.CTX.beginPath()
						Draw.CTX.moveTo prev_l.l.x + prev_point.x, prev_l.l.y + prev_point.y
						Draw.CTX.lineTo l.l.x + point.x, l.l.y + point.y
						Draw.CTX.stroke()
						Draw.CTX.globalAlpha = 1

			selection:->

				@mating_pool = []

				for letter, i in @letters

					letter.l.fitness()

				for letter in @letters
					fit = Math.abs(Math.floor(letter.l.fitness_score))
					j = 0
					while j < fit
						@mating_pool.push letter.l.dna
						j++

			reproduce:->

			evolve:->

				@selection()

				for letter, i in @letters

					rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
					dna_A = @mating_pool[rnd_dna]

					letter.l.evolve dna_A, i
					letter.l.update()




