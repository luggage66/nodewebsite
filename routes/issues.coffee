Database = require '../lib/database'
async = require 'async'

db = Database()
exports = module.exports

exports.getIssues = (req, res) ->
	db.smembers 'all.issues', (err, issues) ->
		res.render 'issues', { issues: issues || [] }

exports.getIssue = (req, res) ->
	id = req.params.id

	async.series
		issue: (cb) ->
			db.hgetall 'issue:' + id, cb
		comments: (cb) ->
			db.sort 'issue:' + id + ':comments', 'GET', 'comment:*->body', cb
		, (err, results) ->
			res.render 'issue',
				id: id
				summary: results.issue.summary
				comments: results.comments

exports.createIssue = (req, res) ->
	db.incr 'next.issue.id', (err, id) ->

		async.series [
			(cb) ->
				db.hset 'issue:' + id, 'summary', req.body.summary, cb
			(cb) ->
				db.sadd 'all.issues', id, cb
			], (err, results) ->
				res.redirect '/issue/' + id

exports.createIssueForm = (req, res) ->
	res.render 'newissue', {}

exports.addComment = (req, res) ->
	id = req.params.id
	body = req.body.body

	db.incr 'next.comment.id', (err, commentId) ->
		commentKey = 'comment:' + commentId
		issueKey = 'issue:' + id
		issueCommentSet = 'issue:' + id + ':comments'

		async.series [
			(callback) ->
				db.hmset commentKey,
					issue: id
					body: body
					, callback
			(callback) ->
				db.sadd issueCommentSet, commentId, callback
			], (err, results) ->
				res.redirect '/issue/' + id
