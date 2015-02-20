module.exports = class LSystem

	sentence: ""
	ruleset: []
	generation: 0
	sentences: []

	constructor:(@axiom, r)->

		@sentence = @axiom
		@sentences.push @sentence
		@ruleset = r

	reset:->
		@sentences = []
		@sentence = @axiom

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

		@sentences.push nextgen

		@sentence = nextgen
		@sentence

	get_sentences:->

		@sentences
