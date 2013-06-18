window.requestAnimFrame = do -> window.requestAnimationFrame or window.webkitRequestAnimationFrame or window.mozRequestAnimationFrame or ( callback ) -> window.setTimeout(callback, 1000 / 60)
Object.getPrototypeOf(document.createElement("canvas").getContext("2d")).fillRectR = (x, y, w, h, r) ->
	r = 5	if typeof r is "undefined"
	@beginPath()
	@moveTo x + r, y
	@lineTo x + w - r, y
	@quadraticCurveTo x + w, y, x + w, y + r
	@lineTo x + w, y + h - r
	@quadraticCurveTo x + w, y + h, x + w - r, y + h
	@lineTo x + r, y + h
	@quadraticCurveTo x, y + h, x, y + h - r
	@lineTo x, y + r
	@quadraticCurveTo x, y, x + r, y
	@closePath()
	@fill()

Object.getPrototypeOf(document.createElement("canvas").getContext("2d")).strokeRectR = (x, y, w, h, r) ->
	r = 5	if typeof r is "undefined"
	@beginPath()
	@moveTo x + r, y
	@lineTo x + w - r, y
	@quadraticCurveTo x + w, y, x + w, y + r
	@lineTo x + w, y + h - r
	@quadraticCurveTo x + w, y + h, x + w - r, y + h
	@lineTo x + r, y + h
	@quadraticCurveTo x, y + h, x, y + h - r
	@lineTo x, y + r
	@quadraticCurveTo x, y, x + r, y
	@closePath()
	@stroke()

class FrameBuffer extends BaseObject

	constructor: (@buffer) ->
		@buffer ?= document.createElement("canvas")
		@context = @buffer.getContext("2d")
		@context.translate(0.5, 0.5)
		do @_hookSizeModif
		@echo "FrameBuffer Ready"

	_hookSizeModif: =>
		window.addEventListener "resize", @_sizeModif
		@_sizeModif true

	_sizeModif: (bypass = false) =>
		@buffer.width = window.innerWidth
		@buffer.height = window.innerHeight
		do @sequence if not bypass

	start: => @_start?(); @running = true; do @tick 
	end: => @running = false

	tick: => 
		do @sequence 
		if @running then requestAnimFrame(@tick) 
		else 
			@_end?()
	sequence: => console.log "Tick width: #{@buffer.width}, height: #{@buffer.height}"; debugger

	getX: (from) => ( from.x or 0 ) + ( @parent.offsets?.x or 0 )
	getY: (from) => ( from.y or 0 ) + ( @parent.offsets?.y or 0 )

	makeValue: (value, delta) => value + delta * value / 4 
	getWidth: (delta) => @makeValue (@parent.sizes?.x or 300), delta
	getHeight: (delta) => @makeValue (@parent.sizes?.y or 300), delta
	getTextDelta: (delta) => @makeValue 30, delta
	alphaDelta: (delta) => (1 + delta / 4) or 0.2


module.exports = FrameBuffer
