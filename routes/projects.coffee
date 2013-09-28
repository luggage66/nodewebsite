domain = require '../lib/domain'

exports = module.exports

exports.lookupProject = (req, res, next, project) ->
	await domain.Project.findOne
		name: project
		, defer err, projectData

	#await db.hgetall "project:#{project}", defer err, projectData

	if projectData
		req.project = projectData
		next()
	else
		next(new Error("project '#{project}' not found."))

exports.get = (req, res) ->
	project = req.project

	await domain.Issue.find _project: project._id, defer err, issues

	res.render 'project/index',
		project: project
		issues: issues || []

exports.createProjectForm = (req, res) ->
	res.render 'project/new'

exports.createProject = (req, res, next) ->
	project = new domain.Project
		name: req.body.name
		description: req.body.description

	await project.save defer err
	if err
	  next(err)

	res.redirect "/#{project.name}"
