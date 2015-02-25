sys = []

index = 0

sys.push
  n: 3
  len: 11
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF----F+FFF-F++F-FF"
  x: 20
  y: 50

sys.push
  n: 3
  len: 10
  theta: 10
  axiom: "F-F+F-F+F"
  rule: "FF-F-F+FF"
  x: 250
  y: 50

sys.push
  n: 3
  len: 80
  theta: 120
  axiom: "F-F-F-F"
  rule: "F-F+F-F"
  x: 60
  y: 150

sys.push
	n: 3
	len: 7
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-F+F+FF-F-F+F"
	x: 150
	y: 200

sys.push
	n: 3
	len: 30
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F+F-F-FF"
	x: -50
	y: -150

sys.push
	n: 4
	len: 6
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F-F-F-F-F+F"
	x: 250
	y: -120

sys.push
	n: 4
	len: 8
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F-F-F-FF"
	x: 225
	y: 250

sys.push
	n: 4
	len: 8
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F--F-F"
	x: 220
	y: 220

sys.push
	n: 4
	len: 25
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: 200
	y: 200

sys.push
	n: 4
	len: 23
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-FF--F-F"
	x: 150
	y: -230

sys.push
	n: 4
	len: 23
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: 200
	y: 200


exports.get_sys = ()->
	rule = sys[index]
	index++

	if index > sys.length - 1
		index = 0

	rule
