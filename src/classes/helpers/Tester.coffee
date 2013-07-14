# Prefixes for some things like IndexedDB or RequestAnimationFrame
PREFIXES = ["moz", "webkit", "ms"]

# A list of tests to figure out how to run the app
TESTS =
	"indexeddb": ->
		# Checking wether the base indexedDB exists
		if window.indexedDB then return true
		
		# Else, check if one of the other ones are available
		return true for prefix in PREFIXES when window["#{prefix}IndexedDB"]?
		false
		
	"localstorage": -> chrome?.storage? or window.localStorage? # Only two things to check here : normal API and Chrome local Storage

# A list of functions that normalize some stuff relating to databases and stuff
NORMIALIZES =
	"indexeddb": -> unless window.indexedDB
		# These are the props that belong to indexedDB
		PROPS = ["IDBCursor", "IDBCursorWithValue", "IDBTransaction", "IDBDatabase", "IDBIndex", "IDBKeyRange", "IDBFactory", "IDBObjectStore", "IDBOpenDBRequest", "IDBRequest", "IDBVersionChangeEvent"]

		# Getting the right one and normalizing it
		for prop in PROPS
			window[prop] = window["#{prefix}#{prop}"] for prefix in PREFIXES when window["#{prefix}IndexedDB"]?

		# And finally indexedDB itself is normalized
		window.indexedDB = window["#{prefix}IndexedDB"] for prefix in PREFIXES when window["#{prefix}IndexedDB"]?

	"localstorage": ->
		# If running the app in a chrome packaged app, use chrome local localstorage
		window.LocalStorage = {}
		if chrome? and chrome.storage?
			window.LocalStorage.set = (key, value) -> chrome.storage.local.set key: value
			window.LocalStorage.get = chrome.storage.local.get
			window.LocalStorage.remove = chrome.storage.local.remove
		# Else run the regular localstorage with a slightly different API
		else
			window.LocalStorage.set = (key, value) -> localStorage.setItem key, value
			window.LocalStorage.get = (item, callback) -> res = {}; res[item] = window.localStorage.getItem item; callback res
			window.LocalStorage.remove = (item) -> window.localStorage.removeItem item

# Finally wrapping them up in an object that runs the tests, runs the normalizes and makes the test results available
# Also, if a test was unsuccesful then the normalize function associated never runs
class Tester extends IS.Object
	constructor: -> @log "Tester Online"; do @tests; do @normalize
	tests: -> @[name] = do test for name, test of TESTS
	normalize: -> do normalize for name, normalize of NORMIALIZES when @[name]

module.exports = Tester
