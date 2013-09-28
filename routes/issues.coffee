domain = require '../lib/domain'

exports = module.exports

exports.lookupIssue = (req, res, next, issue) ->
	await domain.Issue.findById issue, defer err, issueData

	if issueData
		req.issue = issueData
		next()
	else
		next(new Error("issue '#{issue}' not found."))

exports.getIssues = (req, res) ->
	domain.Issue.find _project: req.project._id, defer err, issues

	res.render 'issues', { issues: issues || [] }

exports.getIssue = (req, res) ->
	
	await domain.Comment.find _issue: req.issue._id, defer err, comments

	res.render 'issue',
		issue: req.issue
		comments: comments || []

exports.createIssue = (req, res, next) ->

	issue = new domain.Issue
		_project: req.body._project
		summary: req.body.summary
		description: req.body.description
		labels: req.body.labels

	await issue.save defer err

	if err
	  next(err)

	res.redirect "/#{req.project.name}/issues/#{issue._id}"

exports.createIssueForm = (req, res) ->
	res.render 'newissue',
		components: ['one', 'two']
		project: req.project

exports.addComment = (req, res, next) ->
	id = req.params.id

	next(new Error 'not implemented')
