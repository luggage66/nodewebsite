require './database'
mongoose = require 'mongoose'

projectSchema = new mongoose.Schema
	name: String
	description: String

module.exports.Project = mongoose.model 'Project', projectSchema

issueSchema = new mongoose.Schema
	_project: type: mongoose.Schema.Types.ObjectId, ref: 'Project', index: true
	summary: String
	description: String
	labels: [ String ]

module.exports.Issue = mongoose.model 'Issue', issueSchema

commentSchema = new mongoose.Schema
	_issue: type: mongoose.Schema.Types.ObjectId, ref: 'Issue', index: true
	created: Date
	body: String

module.exports.Comment = mongoose.model 'Comment', commentSchema