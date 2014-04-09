$ = require 'bling'
Fs = require 'fs'

class DataSet
	constructor: (@filename, @codec=JSON) ->
		$.extend @, $.Promise()
		Fs.exists @filename, (exists) =>
			if exists then Fs.readFile @filename, (err, data) =>
				return @ready.fail(err) if err
				@data = @codec.parse data
				@finish @
			else
				@data = []
				@finish @
		idx = {}
		@ensureIndex = (field, unique=true) =>
			return if field of idx
			idx[field] = index = Object.create(null)
			@wait (err) =>
				return if err
				for item, i in @data then switch
					when unique then index[item[field]] = { unique: true, items: [i] }
					else (index[item[field]] ?= { unique: false, items: [] }).items.push i
		@queryIndex = (query) =>
			p = $.Promise()
			@wait (err) =>
				return p.fail(err) if err
				sets = []
				for field of query when field of idx
					try set.push (index for index in idx[field][query[field]])
				p.finish sets
			p

# new DataSet('shows.json').ensureIndex('name', true).wait (err, dataSet) ->
	# $.log err, dataSet

Fs.readFile 'data/magnets', (err, data) ->
	throw err if err
	$.log "finished reading file"
	data = data.toString()
	lines = data.replace(/magnet:\?/g,'').split "\n"
	$.log "read #{lines.length} lines"
	objects = []
	for line,l in lines
		obj = { magnet: "magnet:?#{line}" }
		for pair in line.split '&'
			[key, value] = pair.split '='
			if key of obj
				unless $.is 'array', obj[key]
					obj[key] = [ obj[key] ]
				obj[key].push value
			else
				obj[key] = value
		objects.push obj
	
	$.log "parsed #{objects.length} objects"
	objects = $(objects).index((x) -> x.dn).index((x) -> x.tr)
	$.log "indexed #{objects.length} objects"
	$.log objects.query( dn: "Friday.Night.Lights.S05E09.HDTV.XviD-NoTV" )
	$.log objects.query( tr: "udp://tracker.openbittorrent.com:80" )
	null
	

# magnet:?xt=urn:btih:P6PETHJCFY35WYPYXGRYJ2QGR6N3GPLA&dn=Friday.Night.Lights.S05E09.HDTV.XviD-NoTV&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.publicbt.com:80&tr=udp://tracker.istole.it:80&tr=udp://open.demonii.com:80&tr=udp://tracker.coppersurfer.tk:80

		



