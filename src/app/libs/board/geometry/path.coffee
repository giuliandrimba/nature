module.exports = class Path

	path:[]

	counter:0

	constructor:(@element, @color = "#fff", @thickness=1, @interval=1)->
		@context = @element.context
		@element.scene.on "update", @draw

	draw:()=>


		if (@counter % @interval) is 0
			@path.push 
				x: @element.x
				y: @element.y
		@counter++

		@context.strokeStyle = @color
		@context.lineWidth = @thickness
		@context.beginPath()
		@context.moveTo @path[0].x, @path[0].y

		for point, i in @path
				@context.lineTo point.x, point.y

		@context.stroke()
		@context.closePath()