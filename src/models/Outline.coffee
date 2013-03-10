_map =
	unchecked: "icon-check-empty"
	checked: "icon-check"
	determinate: "icon-circle"
	indeterminate: "icon-circle-blank"

_params     = [ "status", "note", "text", "children" ]
_checkParam = (object, field, param, from) -> object[field] = from.getAttribute(param) or ""

class OutlineCollection extends BaseObject
	constructor: (bodyElement = null, @parent, @depth = 0) ->
		if not bodyElement then @topics = [] 
		else @topics = do =>
			new Outline element, @ for element in bodyElement when element.tagName is "outline"
	remove: (item) -> @topics.splice (@topics.indexOf item), 1

class FakeOutline
	constructor: (@text = "New Node", @_status = "unchecked", @childNodes = []) ->
	getAttribute: (attr) -> @[attr] or null

class Outline
	constructor: (xmlDoc = null, @parent) ->
		xmlDoc ?= new FakeOutline()
		@getData xmlDoc
		@_map = _map

	getData: (xmlDoc) =>
		@fold = false
		@[what] = null for what in _params
		_checkParam @, "text", "text", xmlDoc
		_checkParam @, "status", "_status", xmlDoc
		_checkParam @, "note", "_note", xmlDoc
		_children = new OutlineCollection xmlDoc.childNodes, @, @parent.depth + 1
		@children = (if _children.topics.length then _children else null)
		if @status is ""
			if not (@children? and @children.topics.length) then @status = "unchecked"

	getStatus: => 
		if @children? and @children.topics.length
			done = 1
			for kid in @children.topics
				if not (kid.status in ["checked", "determinate"])
					@status = "indeterminate"
					done = 0
					break
			@status = "determinate" if done
		else if @status in ["determinate", "indeterminate"] then @status = "unchecked"
		_map[@status]

	addChild: =>
		if not @children? then @children = new OutlineCollection false, @, @parent.depth + 1
		@children.topics.push new Outline null, @children

class OutlineErrorReporter extends BaseObject

	@errors: 
		"UpdateError": ["Must give a proper property to update!"]

ER = OutlineErrorReporter


module.exports =
	Collection: OutlineCollection
	Element: Outline
	generate: (xml) -> new OutlineCollection xml.getElementsByTagName("body")[0].childNodes
