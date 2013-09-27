Database = require '../lib/database'
async = require 'async'

db = Database()
exports = module.exports

exports.getIssues = (req, res) ->
	await db.smembers 'all.issues', defer err, issues

	res.render 'issues', { issues: issues || [] }

exports.getIssue = (req, res) ->
	id = req.params.id

	await db.hgetall "issue:#{id}", defer err, issue
	await db.sort "issue:#{id}:comments", 'GET', 'comment:*->body', defer err, comments
	await db.smembers "issue:#{id}:components", defer err, components

	res.render 'issue',
		id: id
		issue: issue
		comments: comments
		components: components

exports.createIssue = (req, res) ->
	issueData =
		summary: req.body.summary
		description: req.body.description

	components = req.body.components

	await db.incr 'next.issue.id', defer err, id
	await db.hmset "issue:#{id}", issueData, defer err
	await db.sadd "issue:#{id}:components", components, defer err
	await db.sadd 'all.issues', id, defer err

	res.redirect '/issue/' + id

exports.createIssueForm = (req, res) ->
	await db.smembers 'all.components', defer err, components
	
	res.render 'newissue',
		components: components || []

exports.addComment = (req, res) ->
	id = req.params.id

	commentData = 
		issue: id
		body: req.body.body

	await db.incr 'next.comment.id', defer err, commentId
	await db.hmset "comment:#{commentId}", commentData, defer err
	await db.sadd "issue:#{id}:comments", commentId, defer err

	res.redirect '/issue/' + id
