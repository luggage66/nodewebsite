domain = require './domain'
db = require './database'

projectsMade = 0

createProject = (callback) ->
	projectName = 'project-' + projectsMade++
	console.log "creating #{projectName}"

	project = new domain.Project
		name: 'project-' + projectsMade++

	await project.save defer err, project

	callback err

module.exports.populateDatabase = (options) ->
	options ?= {}
	options.clearExistingData ?= false;

	if options.clearExistingData
		console.log 'removing comments'
		await domain.Comment.remove {}, defer err
		console.log 'removing projects'
		await domain.Project.remove {}, defer err
		console.log 'removing issues'
		await domain.Issue.remove {}, defer err

	console.log 'creating projects'
	#create projects
	await
		for x in [1..3]
			createProject defer err

	console.log 'done creating projects'
