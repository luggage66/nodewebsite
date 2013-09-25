exports = module.exports

exports.getIssues = (req, res) ->
	res.render 'issues', {}

exports.getIssue = (req, res) ->
	res.render 'issue', { id: req.params.id }