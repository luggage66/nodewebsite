issues = require './issues'

routes = 
	'/issues': 
		get: issues.getIssues
		'/:id':
			get: issues.getIssue


module.exports = (app) ->
	map = (a, route) ->
		route = route || ''

		for key, val of a
			switch (typeof val)
				when 'object'
					map val, route + key
				when 'function'
					app[key] route, val
	map routes
