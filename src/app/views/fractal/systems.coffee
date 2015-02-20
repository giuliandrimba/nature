sys = []

sys.push
	n: 5
	len: 2
	theta: 25.7
	axiom: "F"
	rule: "F[+F]F[-F]F"
	x: 0
	y: 0

# sys.push
# 	n: 5
# 	len: 5
# 	theta: 20
# 	axiom: "F"
# 	rule: "F[+F]F[-F][F]"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 7
# 	theta: 22.5
# 	axiom: "F"
# 	rule: "FF-[-F+F+F]+[+F-F-F]"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 3
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "FF-F-F-F-F-F+F"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 7
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "FF-F-F-F-FF"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 3
# 	len: 14
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "FF-F+F-F-FF"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 7
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "FF-F--F-F"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 14
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "F-FF--F-F"
# 	x: 0
# 	y: 0

# sys.push
# 	n: 4
# 	len: 15
# 	theta: 90
# 	axiom: "F-F-F-F"
# 	rule: "F-F+F-F-F"
# 	x: 0
# 	y: 0

exports.get_sys = ()->

	last = sys.length - 1
	sys[last]
