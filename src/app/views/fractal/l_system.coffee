module.exports = class LSystem

	sentence: ""
	ruleset: []
	generation: 0

	constructor:(axiom, r)->

		@sentence = axiom
		@ruleset = r

	generate:->

		nextgen = ""

		for c, i in @sentence

			curr = @sentence.charAt i

			replace = curr

			for r, j in @ruleset

				a = r.a

				if a is curr
					replace = r.b
					break

			nextgen += replace

		@sentence = nextgen
		@generation++

	get_sentence:->

		@sentence
