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

				total_width = 120 * @total
				total_height = (@TOTAL_LETTERS / (@total + 1)) * 170
				init_x = (@width / 2) - (total_width / 2)
				init_y = (@height / 2) - (total_height / 2)

				i = 0

				while i < @TOTAL_LETTERS

					l = new Letter init_x + (@column * 120), init_y + (@line * 170), alphabet.A
					@column++

					if @column > @total
						@line++
						@column = 0

					@letters.push l

					i++

			update:->

			mousedown:->
				@evolve()

			mouseup:->

			draw:->
				Draw.CTX.fillStyle = "rgba(0,0,0,0.05)"
				Draw.CTX.fillRect(0, 0, @width, @height)

				for l in @letters
					l.draw()

			selection:->

				@mating_pool = []

				for letter, i in @letters

					letter.fitness()

				for letter in @letters
					fit = Math.abs(Math.floor(letter.fitness_score))
					j = 0
					while j < fit
						@mating_pool.push letter.dna
						j++

			reproduce:->

			evolve:->

				@selection()

				for letter, i in @letters

					rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
					dna_A = @mating_pool[rnd_dna]

					letter.evolve dna_A, i
					letter.update()




