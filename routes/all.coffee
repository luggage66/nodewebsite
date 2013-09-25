git = require 'git'
async = require 'async'
fs = require 'fs'
path = require 'path'

module.exports = (app) ->
	app.get '/', (req, res) ->
		fs.readdir 'repos', (err, files) ->
			res.render 'index', 
				title: "Express"
				repos: files.map (file) ->
					path.basename file, '.git'

	app.param 'repo', (req, res, next, repoName) ->
		new git.Repo 'repos/' + repoName + '.git', (err, repo) ->
			req.repo = repo
			next()

	app.get '/settings', (req, res) ->
		res.render 'settings',  {}

	app.get '/:repo', (req, res) ->
		viewModel = 
			title: 'repo'

		async.series [
			(callback) ->
				req.repo.tags (err, tags) ->
					viewModel.tags = tags
					callback null
		], (err, result) ->
			res.render 'repo', viewModel
		