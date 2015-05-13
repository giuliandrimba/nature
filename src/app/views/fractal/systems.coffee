sys = []

index = 0

sys.push
  n: 3
  len: 50
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF----F+FFF-F++F-FF"
  x: 20
  y: 50

sys.push
  n: 4
  len: 50
  theta: 10
  axiom: "F-F+F-F+F"
  rule: "FF-F-F+FF"
  x: 500
  y: 50

sys.push
  n: 4
  len: 300
  theta: 120
  axiom: "F-F-F-F"
  rule: "F-F+F-F"
  x: 250
  y: 500

sys.push
	n: 3
	len: 30
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-F+F+FF-F-F+F"
	x: 500
	y: 200

sys.push
	n: 3
	len: 200
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F+F-F-FF"
	x: -50
	y: -300

sys.push
	n: 3
	len: 55
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F-F-F-F-F+F"
	x: 450
	y: 600

sys.push
	n: 3
	len: 75
	theta: 90
	axiom: "F-F-F-F"
	rule: "FF-F-F-F-FF"
	x: 1000
	y: 1000

sys.push
	n: 4
	len: 400
	theta: 60
	axiom: "F-F-F-F"
	rule: "FF-F--F-F"
	x: 220
	y: 220

sys.push
	n: 4
	len: 250
	theta: 100
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: 200
	y: 200

sys.push
	n: 4
	len: 100
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-FF--F-F"
	x: 350
	y: -1000

sys.push
	n: 3
	len: 900
	theta: 150
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: -200
	y: -500


exports.get_sys = ()->
	rule = sys[index]
	index++

	if index > sys.length - 1
		index = 0

	rule
