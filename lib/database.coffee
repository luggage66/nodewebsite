redis = require 'redis'

module.exports = () ->
	client = redis.createClient()

	client.on 'error', (err) ->
		console.log 'Redis Error: ' + err

	client
