class OPML extends BaseObject

	constructor: (@text = null, @manager) ->
		@parse @text if @text?
		@marked = []
		@events = {}
		@events["outline.#{@title}.addChild"] = @_addChild
		@events["outline.#{@title}.edit"] = @_modify
		@events["outline.#{@title}.removeChild"] = @_removeChild
		@events["outline.#{@title}.move"] = @_move
		@events["outline.#{@title}.startMoving"] = @_startMoving
		@events["outline.#{@title}.endMoving"] = @_endMoving
		@events["outline.#{@title}.markEdit"] = @_markEdit
		@events["outline.#{@title}.unMarkEdit"] = @_unMarkEdit
		Client?.events = @events
		Client?.loadEvents()

	parse: (text) =>
		parser = new DOMParser
		xml = parser.parseFromString text, "text/xml"
		@JSONize xml

	JSONize: (xml) =>
		@title = xml.getElementsByTagName("title")[0].childNodes[0].nodeValue
		@expansionSet = ""
		@expansionSet = xml.getElementsByTagName("expansionState")[0]?.childNodes[0].nodeValue or ""
		@expansionSet = @expansionSet.replace(/\ /g, "").split ","
		@expansionSet[index] = parseInt @expansionSet[index] for value, index in @expansionSet
		@structure = (DepMan.model "Outline").generate xml
		do @regenIndices
		@locationService = new (DepMan.helper "Locations")(@)
		console.log @structure
		@controller = new (DepMan.controller "OPML")( @ )

	regenIndices: =>
		index = 0
		regenIndices = (collection) =>
			return if not collection?
			for kid in collection.topics
				kid.index = index++
				if kid.children then regenIndices kid.children
				console.log kid.index, @expansionSet
				if not (kid.index in @expansionSet) then kid.fold = true
		regenIndices @structure

	getIndices: => 
		indices = []
		getIndices = (collection) =>
			return if not collection?
			for kid in collection.topics
				if not kid.fold then indices.push kid.index
				if kid.children then getIndices kid.children
		getIndices @structure
		indices

	find: (search = [], start = null) =>

		search = search.split "." if search.substr?
		start = @structure if not start

		next = search.shift()
		el = null
		for kid in start.topics
			if kid.text is next then el = kid; break

		return el if search.length is 0
		return null if not el? or not el.children?
		return @find search, el.children

	checkProp: (into, from, prop) ->
		aux = from.getAttribute prop
		if aux? then into[prop.substr 1].set aux

	download: =>
		window.open "data:application/xml,#{( do @Export ).replace /["']/g, "\""}"


	Export: => "<opml version='1.0'><head><title>#{@title}</title><expansionState>#{(do @getIndices).join ','}</expansionState></head><body>#{do @exportBody}</body></opml>"

	exportBody: (tree = @structure) =>
		string = ""
		for kid in tree.topics
			string += "<outline text='#{kid.text.replace("\"", "&#34;").replace("'", "&#39;")}' "
			string += "_note='#{kid.note.replace("\"", "&#34;").replace("'", "&#39;").replace("\n", " ")}' " if kid.note?
			string += "_x='#{kid.x}' _y='#{kid.y}' "
			if kid.status? then string += "_status='#{kid.status}'"
			else if kid.children?
				kids = kid.children.topics
				valid = true
				for newkid in kids
					if not ( newkid.status in ["checked", "determinate" ] )
						valid = false
						break
				if valid then string += "_status='determinate'"
				else string += "_status='indeterminate'"
			else string += "_status='unchecked'"
			if kid.children then string += ">#{@exportBody kid.children}</outline>"
			else string += "/>"
		string.replace "\n", ""

	save: =>
		window.storage?.setItem "opmls.#{@title}", do @Export
		window.storage.getItem "opmls", (sets) =>
			sets.opmls ?= "[]"
			storageIndex = JSON.parse sets.opmls
			if not storageIndex then window.storage.setItem "opmls", JSON.stringify [@title]
			else if not ( @title in storageIndex )
				if @pastTitle?
					storageIndex.splice (storageIndex.indexOf @pastTitle), 1
					storage.removeItem "opmls.#{@pastTitle}"
					delete @pastTitle
				storageIndex.push @title
				window.storage?.setItem "opmls", ( JSON.stringify storageIndex ).replace /<br\/?>/g, ""
			Toast "Saved #{@title}", "OPML Document saved. You can now return to ruining it, without the worry of loosing it."

	findNode: (path, from = @structure) =>
		#alert "Arrived with path #{path}"
		el = do path.shift
		for kid in from.topics
			#alert "Comparing #{el} with #{kid.text}"
			if kid.text is el
				if path.length > 0 then return @findNode path, kid.children
				else return kid
		return null

	modify: (path, data) => Client.publish "outline.#{@title}.edit", path, data
	addChild: (path) => Client.publish "outline.#{@title}.addChild", path
	rename: (title) => Client.publish "outline.#{@title}.rename", title
	removeChild: (path) => Client.publish "outline.#{@title}.removeChild", path
	startMoving: => Client.publish "outline.#{@title}.startMoving"
	endMoving: => Client.publish "outline.#{@title}.endMoving"
	move: (path, to) => Client.publish "outline.#{@title}.move", ( JSON.stringify path ), ( JSON.stringify to )
	markEdit: (path) => Client.publish "outline.#{@title}.markEdit", ( JSON.stringify path )
	unMarkEdit: (path) => Client.publish "outline.#{@title}.unMarkEdit", ( JSON.stringify path )

	_markEdit: (path) => @marked.push (JSON.parse path).join ", "

	_unMarkEdit: (path) => @marked.splice (@marked.indexOf (JSON.parse path).join ", "), 1

	_modify: (path, data) =>
		item = @findNode JSON.parse path
		console.log path, item, data
		item.text = data.text if data.text?
		item._text = data.text if data.text?
		if data.status?
			if item.status in ["checked", "unchecked"]
				item.status = data.status
		item.note = data.note if data.note?
		item.fold = data.fold if data.fold?
		do @_refresh

	_refresh: =>
		do @refreshView if @refreshView?		
		do @controller.frameBuffer.sequence if @controller.frameBuffer?

	_addChild: (path) =>
		item = @findNode JSON.parse path
		item.addChild(@locationService.getNextChild path.length)
		do @_refresh

	_rename: (title) =>
		@events["outline.#{title}.addChild"] = @events["outline.#{@title}.addChild"]
		@events["outline.#{title}.edit"] = @events["outline.#{@title}.edit"]
		@events["outline.#{title}.removeChlid"] = @events["outline.#{@title}.removeChlid"]
		@events["outline.#{title}.move"] = @events["outline.#{@title}.move"]
		@events["outline.#{title}.startMoving"] = @events["outline.#{@title}.startMoving"] 
		@events["outline.#{title}.endMoving"] = @events["outline.#{@title}.endMoving"]
		@events["outline.#{title}.markEdit"] = @events["outline.#{@title}.markEdit"]
		@events["outline.#{title}.unMarkEdit"] = @events["outline.#{@title}.unMarkEdit"]
		Client.queue["outline.#{@title}.addChild"] = null
		Client.queue["outline.#{@title}.edit"] = null
		Client.queue["outline.#{@title}.removeChild"] = null
		Client.queue["outline.#{@title}.move"] = null
		Client.queue["outline.#{@title}.startMoving"] = null
		Client.queue["outline.#{@title}.endMoving"] = null
		Client.queue["outline.#{@title}.markEdit"] = null
		Client.queue["outline.#{@title}.unMarkEdit"] = null
		@events = {}
		Client?.events = @events
		Client?.loadEvents()
		@title = title
		do @_refresh

	_removeChild: (path) =>
		item = @findNode JSON.parse path
		parent = item.parent
		item.parent.remove item
		if not parent.topics.length then parent.parent.children = null
		do @_refresh

	_move: (path, to) =>
		item = @findNode JSON.parse path
		to = JSON.parse to
		item.x = to.x
		item.y = to.y

	_startMoving: => @controller.frameBuffer.start()
	_endMoving: => @controller.frameBuffer.end()


	delete: =>
		JSON.parse storage.getItem "opmls", (sets) =>
			index = sets.index
			if @title in index
				do @controller.deactivate
				storage.removeItem "opmls.#{@title}"
				index.splice (index.indexOf @title), 1
				storage.setItem "opmls", JSON.stringify index

module.exports = OPML
