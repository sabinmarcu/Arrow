class CanvasController extends BaseObject
	constructor: (@parent) -> 
		@events = 
			"mousedown": @down
			"mouseup": @up
			"mousemove": @move
			"touchstart": @down
			"touchend": @up
			"touchmove": @move
		@echo "Controller for #{@parent.model.title} enabled!"
		@appScope = angular.element("[ng-controller='NGAsideController']").scope()

	down: (e) =>
		do e.preventDefault
		do @parent.model.scope.cancelSidebar
		@appScope ?= angular.element("[ng-controller='NGAsideController']").scope()
		if @appScope.sidebarstatus is "open"
			@appScope.togglesidebar "closed"
			return false
		@init = @getPos e
		do @parent.Aux.sequence
		@node = @parent.Aux.scan @init
		if not @node 
			@initOffset = x: @parent.offsets.x, y: @parent.offsets.y
			@isMovement = false
			@timer = setTimeout =>
				if not @isMovement 
					do @parent.model.scope.toggleSidebar
					do @up
			, 200		
		else
			node = []
			node.push item for item in @node
			node = @parent.model.findNode node
			@initOffset = x: node.x, y: node.y
			@isMovement = false
			@timer = setTimeout =>
				if not @isMovement 
					@parent.model.scope.edit node
					do @up
			, 100

	move: (e) =>
		pos = @getPos e
		@isMovement = true
		if not @init? 
			node = @parent.Aux.scan pos
			if node 
				if node in ["{{PLUS}}", "{{MINUS}}"] then console.log "BUTTON"
				else @parent.buttons = node
			else @parent.buttons = null
		else 
			if @node then @parent.model.move @node,
				x: @initOffset.x + pos.x - @init.x
				y: @initOffset.y + pos.y - @init.y
			else @parent.offsets = x: pos.x - @init.x + @initOffset.x, y: pos.y - @init.y + @initOffset.y

			do e.preventDefault
		
	up: (e) =>
		if not @isMovement and @node then @parent.model.scope.edit @parent.model.findNode @node
		@init = null
		@node = null
		@isMovement = false
		clearTimeout @timer
		do e.preventDefault

	getPos: (e) =>
		if e.touches then e = e.touches[0]
		x: e.pageX, y: e.pageY

	keyHandler: (e) =>
		switch String.fromCharCode(e.keyCode).toLowerCase()
			when 'l' then @toggle "legend"
			when 'g' then @toggle "levelno"
			when 'd' then @toggle "level"
			when 's' then @toggle "shortcuts"
			when "!" then @parent.level++
			when "\"" then @parent.level-- if @parent.level > 0

	toggle: (what) -> 
		@parent.triggers[what] = !@parent.triggers[what]
		storage.setItem "canvasTriggers", JSON.stringify @parent.triggers

	mouseWheelHandler: (e) => 
		@mwTick ?= -1
		@mwTolerance ?= 6
		@mwTick++
		if @mwTick is @mwTolerance 
			@parent.level += e.wheelDelta / 120
			@parent.level = 0 if @parent.level < 0 
			@mwTick = 0

	start: =>
		window.addEventListener "keydown", @keyHandler
		window.addEventListener "mousewheel", @mouseWheelHandler
		@parent.buffer.addEventListener ev, handler for ev, handler of @events

	end: =>
		window.removeEventListener "keydown", @keyHandler
		window.removeEventListener "mousewheel", @mouseWheelHandler
		@parent.buffer.removeEventListener ev, handler for ev, handler of @events

module.exports = CanvasController