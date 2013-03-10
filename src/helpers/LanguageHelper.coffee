class LanguageHelper extends BaseObject
	constructor: (language) ->
		lang = localStorage.getItem "lang"
		language = lang or "en-US"
		@timer = setTimeout((=> @log "Initialized"), 0)
		@switchLanguage language
		
	switchLanguage: (@language) =>
		try
			require "languages/#{@language}"
			@_language = JSONImport["#{@language}"]
			localStorage.setItem "lang", @language
			do @_translateAll
		catch e
			@log "Error Encountered", e
			
	_translate: (text) => @_language[text] or text
	_hook: (text, area=null) => 
		clearTimeout @timer
		@timer = setTimeout @_translateAll, 0
		string = "data-translate = '#{text}'"
		string += " data-target='#{area}'" if area?
		string
	_translateAll: =>
		me = @
		jQuery("*[data-translate]").each (element) ->
			if @tagName is "INPUT"
				target = @dataset["target"] or "value"
				@[target] = me._translate @dataset["translate"]
			else @innerHTML = me._translate @dataset["translate"]
	
window.LanguageHelper = new LanguageHelper
window.T = window.LanguageHelper._translate
window._T = window.LanguageHelper._hook