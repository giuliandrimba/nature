sys = []

index = 0

sys.push
  n: 3
  len: 18
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F-F-F-F-F+F"
  x: 300
  y: 50

sys.push
  n: 3
  len: 27
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F-F-F-FF"
  x: 275
  y: 355

sys.push
  n: 3
  len: 35
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F+F-F-FF"
  x: -70
  y: -130

sys.push
  n: 3
  len: 7.5
  theta: 90
  axiom: "F-F-F-F"
  rule: "F-F+F+FF-F-F+F"
  x: 170
  y: 270


sys.push
  n: 4
  len: 70
  theta: 120
  axiom: "F-F-F-F"
  rule: "F-F+F-F"
  x: 120
  y: 300

sys.push
  n: 4
  len: 10
  theta: 10
  axiom: "F-F+F-F+F"
  rule: "FF-F-F+FF"
  x: 250
  y: 150

sys.push
  n: 3
  len: 10
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF----F+FFF-F++F-FF"
  x: -10
  y: 50

sys.push
	n: 4
	len: 50
	theta: 60
	axiom: "F-F-F-F"
	rule: "FF-F--F-F"
	x: 120
	y: 190

sys.push
	n: 4
	len: 26
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-FF--F-F"
	x: 170
	y: -200

sys.push
	n: 3
	len: 150
	theta: 130
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: 40
	y: 70


exports.get_sys = ()->
	rule = sys[index]
	index++

	if index > sys.length - 1
		index = 0

	rule
