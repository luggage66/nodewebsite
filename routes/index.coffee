issues = require './issues'
projects = require './projects'

routes =
	'project':
		param: projects.lookupProject
	'/':
		get: (req, res) ->
			res.redirect '/issue'
		'issue': 
			get: issues.getIssues
			post: issues.createIssue
			'/new':
				get: issues.createIssueForm
			'/:id':
				get: issues.getIssue
				'/comment':
					post: issues.addComment
	'/:project':
		get: projects.get


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
