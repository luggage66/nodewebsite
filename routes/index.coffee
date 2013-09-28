issues = require './issues'
projects = require './projects'

routes =
	'project':
		param: projects.lookupProject
	'issue':
		param: issues.lookupIssue
	'/': #direct children, drop /
		get: (req, res) ->
			res.redirect '/issue'
		'project':
			post: projects.createProject
			'/new':
				get: projects.createProjectForm
	'/:project':
		get: projects.get
		'/issues':
			post: issues.createIssue
			'/new':
				get: issues.createIssueForm
			'/:issue':
				get: issues.getIssue
				'/comment':
					post: issues.addComment



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
