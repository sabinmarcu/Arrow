class DocumentModel extends IS.Object

	@extend IS.Modules.ORM
	
	init: (data) ~> 
		@data = data.element
		@parent = @constructor
		@title = @data.title
		@_id = @_uuid
		if @data.uuid then @parent.relocate @_uuid, @data.uuid
		else @_id = @_uuid
		@data = @data.json.data
		@parent.documents.push @_id
		@refresh!
		@parent.runtime.set "active-document", @_id
		@log "New Document: [#{@title}|#{@_id}]"

	refresh: ~> 
		@initIndex!
		@refreshIndex @data, 0, @
	initIndex: ~>
		@index = 1
		@indexes = []
	refreshIndex: (list, depth, parent, hidden = false) ~>
		for node in list
			node.$index = @index++
			node.$depth = depth
			node.$parent = parent
			node.$status ?= false
			node.$viewmore ?= false
			node.$folded ?= false
			node.$hidden = hidden
			node.note ?= ""
			if not node.status
				if node.children and node.children.length then node.status = "indeterminate"
				else node.status = "unchecked"
			@indexes.push node
			if node.children then @refreshIndex node.children, depth + 1, node, node.$folded
	save: ~> @parent.save @_id
	delete: ~> @parent.delete @_id
	export: ~> @log @; (@parent.reader.read title: @title, data: @data, uuid: @_id).opml

	@inject = (@runtime, @reader) ~> 
		@documents = []
		@get-initial-state!
		@

	@relocate = (init, final) ~> 
		@log "Relocating #{init} to #{final}"
		@_reccords[final] = @_reccords[init]
		@documents.splice @documents.indexOf init, 1, final
		if @runtime.props['active-document'] is init then @runtime.set 'active-document', final
		delete @_reccords[init]
		@_reccords[final]._id = @_reccords[final]._uuid = final

	@get-initial-state = ~>
		docs <~ Storage.get "documents"
		docs ?= []
		if docs.substr? then docs = JSON.parse docs
		for doc in docs
			content <~ Storage.get doc
			@get-document content

	@get-document = (data) ~> 
		data = @reader.read data
		kid = @reuse null, element: data
		kid

	@new = ~> 
		@get-document title: "New Document", data: [
			{text: "Parent Node", children: [
				{text: "Child Node"}, {text: "Second Child Node"}
			]}
			{text: "Sibling"}
		]	

	@delete = (item) ~>
		@deleteLink item
		delete @_reccords[item]
		Storage.remove item
		index = @documents.indexOf item
		@documents = @documents.splice index, 1
		@runtime.set 'active-document', @documents[index-1]
		Toast "Document Status", "The document has been successfuly deleted!"

	@deleteLink = (item) ~>
		items <~ Storage.get "documents"
		items ?= []
		if items.substr? then items = JSON.parse items
		if items.indexOf item >= 0
			items.splice (items.indexOf item), 1
			Storage.set "documents", JSON.stringify items

	@save = (item) ~>
		@saveLink item
		Storage.set item, @_reccords[item].export!
		Toast "Document Status", "The document has been successfuly saved!"

	@saveLink = (item) ~>
		items <~ Storage.get "documents"
		items ?= []
		if items.substr? then items = JSON.parse items
		unless (items.indexOf item) >= 0
			items.push item
			Storage.set "documents", JSON.stringify items



angular.module AppInfo.displayname .factory \Documents, [ "Runtime", \OPMLReader, DocumentModel.inject ]
module.exports = window.Documents = DocumentModel
