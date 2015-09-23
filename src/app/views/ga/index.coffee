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
			finished: 0
			done: false

			time: undefined
			loop : []
			sound_index: 0


			setup:->

				@sound = new Howl
  				urls: ['audio/bip.wav']

				@time = Date.now()

				Draw.CTX = $(".sketch").get(0).getContext("2d")
				@generation = 1
				@generation_text = $(".label").find("h1")

				@total = Math.ceil(@width / 160)
				@TOTAL_LETTERS = Math.ceil(@height / 170) * @total

				i = 0

				while i < 45
					l = new Letter (30 + @column * 160), (30 + @line * 170), alphabet.A
					@column++

					if @column > @total
						@line++
						@column = 0

					index = Math.floor(Math.random() * 3)
					index2 = Math.floor(Math.random() * l.dna.length)
					@letters.push l:l, i: index, i2:index2

					i++

			update:->

				current = Date.now()

				if current > @time + 1000
					@time = current
					@evolve()

			mousedown:->
				@generation = 1
				@generation_text.text("0#{@generation}")
				@generation_text.removeClass("done")
				for l in @letters
					l.l.reset()

				@done = false
				@time = Date.now()

			mouseup:->

			draw:->
				Draw.CTX.fillStyle = "rgba(0,0,0,0.1)"
				Draw.CTX.fillRect(0, 0, @width, @height)

				for l, i in @letters
					l.l.draw()

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

			reproduce:->

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




