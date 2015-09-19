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
			autoclear:true
			total: 5
			line: 0
			column: 0
			letters: []
			TOTAL_LETTERS: 18
			mating_pool: []
			counter: 0


			setup:->

				Draw.CTX = $(".sketch").get(0).getContext("2d")

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
				# Draw.CTX.fillStyle = "rgba(255,255,255,0.05)"
				# Draw.CTX.fillRect(0, 0, @width, @height)

				for l in @letters
					l.draw()

			selection:->

				@mating_pool = []

				for letter in @letters
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
					rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
					dna_B = @mating_pool[rnd_dna]

					new_dna = @crossover dna_A, dna_B

					if new_dna
						letter.evolve new_dna, i
						letter.update()

				@selection()

			crossover:(a, b)->

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




