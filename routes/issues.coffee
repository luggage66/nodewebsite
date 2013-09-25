exports = module.exports

exports.getIssues = (req, res) ->
	res.render 'issues', {}

exports.getIssue = (req, res) ->
	res.render 'issue', { id: req.params.id }

exports.createIssue = (req, res) ->
	res.redirect '/issue'

exports.createIssueForm = (req, res) ->
	res.render 'newissue', {}