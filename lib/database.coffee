mongoose = require 'mongoose'
Schema = mongoose.Schema

issueSchema = new Schema
	summary: String
	description: String
	
	reportedBy: String
	reportedDate:
		type: Date
		default: Date.now

	components: [String]

	meta:
		votes: Number

Issue = mongoose.model 'Issue', issueSchema

