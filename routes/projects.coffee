Database = require '../lib/database'

db = Database()
exports = module.exports

exports.lookupProject = (req, res, next, project) ->
	await db.hgetall "project:#{project}", defer err, projectData

	if projectData
		req.project = projectData
		next()
	else
		next(new Error("project '#{project}' not found."))

exports.get = (req, res) ->
	project = req.project

	await db.smembers "project:#{project}:labels", defer err, labels

	project.labels = labels | []

	res.render 'project/index', project
