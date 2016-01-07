sys = []

index = 0

sys.push
  n: 3
  len: (18 * $(window).width()) / 1440
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F-F-F-F-F+F"
  x: (300 * $(window).width()) / 1440
  y: (50 * $(window).width()) / 1440

sys.push
  n: 3
  len: (27 * $(window).width()) / 1440
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F-F-F-FF"
  x: (275 * $(window).width()) / 1440
  y: (355 * $(window).width()) / 1440

sys.push
  n: 3
  len: (35 * $(window).width()) / 1440
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF-F+F-F-FF"
  x: (-70 * $(window).width()) / 1440
  y: (-130 * $(window).width()) / 1440

sys.push
  n: 3
  len: (7.5 * $(window).width())/1440
  theta: 90
  axiom: "F-F-F-F"
  rule: "F-F+F+FF-F-F+F"
  x: (170 * $(window).width()) / 1440
  y: (270 * $(window).width()) / 1440


sys.push
  n: 4
  len: (70 * $(window).width()) / 1440
  theta: 120
  axiom: "F-F-F-F"
  rule: "F-F+F-F"
  x: (120 * $(window).width()) / 1440
  y: (300 * $(window).width()) / 1440

sys.push
  n: 4
  len: (10 * $(window).width()) / 1440
  theta: 10
  axiom: "F-F+F-F+F"
  rule: "FF-F-F+FF"
  x: (250 * $(window).width()) / 1440
  y: (150 * $(window).width()) / 1440

sys.push
  n: 3
  len: (10 * $(window).width()) / 1440
  theta: 90
  axiom: "F-F-F-F"
  rule: "FF----F+FFF-F++F-FF"
  x: (-10 * $(window).width()) / 1440
  y: (50 * $(window).width()) / 1440

sys.push
	n: 4
	len: (50 * $(window).width()) / 1440
	theta: 60
	axiom: "F-F-F-F"
	rule: "FF-F--F-F"
	x: (120 * $(window).width()) / 1440
	y: (190 * $(window).width()) / 1440

sys.push
	n: 4
	len: (26 * $(window).width()) / 1440
	theta: 90
	axiom: "F-F-F-F"
	rule: "F-FF--F-F"
	x: (170 * $(window).width()) / 1440
	y: (-200 * $(window).width()) / 1440

sys.push
	n: 3
	len: (150 * $(window).width()) / 1440
	theta: 130
	axiom: "F-F-F-F"
	rule: "F-F+F-F-F"
	x: (40 * $(window).width()) / 1440
	y: (70 * $(window).width()) / 1440


exports.get_sys = ()->
	rule = sys[index]
	index++

	if index > sys.length - 1
		index = 0

	rule
