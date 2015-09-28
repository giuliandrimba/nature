AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
alphabet = require "./alphabet"
Letter = require "./letter"

module.exports = class Index extends AppView

	destroy:->
		@ctx?.clear()
		@ctx?.destroy()
		super

	after_render:=>

		setTimeout @start, 1200

	start:=>

		$(".label").addClass "tween"

		@ctx = window.Sketch.create

			container: @el.find(".lab").get(0)
			fullscreen: true
			autoclear:false
			total_columns: 0
			total_lines: 0
			line: 0
			column: 0
			letters: []
			TOTAL_LETTERS: 30
			mating_pool: []
			counter: 0
			finished: 0
			done: false

			time: undefined
			loop : []
			sound_index: 0

			reset:->

				@time = Date.now()
				@generation = 1
				@generation_text.text("0#{@generation}")
				@total_columns = Math.ceil(@width / 150) - 1
				@total_lines = Math.ceil((@height) / 170) - 1
				@line_spacing = (@height - (@total_lines * 140)) / @total_lines
				@column_spacing = ((@width / 2) - (@total_columns * 150) / 2) + 40
				@TOTAL_LETTERS = @total_columns * (@total_lines)

				@letters = []
				@column = 0
				@line = 0

				i = 0

				while i < @TOTAL_LETTERS
					l = new Letter (@column_spacing + @column * 150), (@line_spacing + @line * 170), alphabet.A
					@column++

					if @column > @total_columns - 1
						@line++
						@column = 0

					index = Math.floor(Math.random() * 3)
					index2 = Math.floor(Math.random() * l.dna.length)
					@letters.push l:l, i: index, i2:index2

					i++

			setup:->

				@sound = new Howl
  				urls: ['audio/bip.wav']
  				volume: 0.5

				Draw.CTX = $(".sketch").get(0).getContext("2d")
				@generation_text = $(".label").find("h1")

			draw_point:(letter)->
				Draw.CTX.beginPath()
				Draw.CTX.arc letter.x + 115, letter.y + 70, 1, 0, Math.PI*2,true
				Draw.CTX.closePath()
				Draw.CTX.fill()

			update:->

				current = Date.now()

				if current > @time + 1000
					@time = current
					@evolve()

			resize:->

				@reset()

			mousedown:->
				@generation = 1
				@generation_text.text("0#{@generation}")
				@generation_text.removeClass("done")
				for l in @letters
					l.l.reset()

				@done = false
				@time = Date.now()

			draw:->
				Draw.CTX.fillStyle = "rgba(0,0,0,0.1)"
				Draw.CTX.fillRect(0, 0, @width, @height)

				for l, i in @letters
					l.l.draw()

					unless (i + 1) % @total_columns is 0
						@draw_point(l.l)

					Draw.CTX.lineWidth = 1

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

			evolve:->

				return if @done
				@sound.play()

				@generation++

				if @generation < 10
					@generation_text.text("0#{@generation}")
				else
					@generation_text.text("#{@generation}")

				@selection()

				for letter, i in @letters

					if letter.l.done
						@finished++

						if @finished >= @TOTAL_LETTERS
							@done = true
							@generation_text.addClass("done")

					else

						rnd_dna =  Math.abs(Math.floor(Math.random() * (@mating_pool.length - 1)))
						dna_A = @mating_pool[rnd_dna]

						letter.l.evolve dna_A, i
						letter.l.update()




