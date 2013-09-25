# Module dependencies.

express = require 'express'
http = require 'http'
path = require 'path'
require 'coffee-script'

app = express()

app.set 'port', process.env.PORT || 3000

#options for handling res.render() calls
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

#request 'pipeline'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser() #parse POST/PUT bodies into req.body
app.use express.methodOverride() #allows _method in body to compensate for lack of support
app.use express.cookieParser('your secret here')
app.use express.session()
app.use app.router #sets the order for the routed requests
app.use require('stylus').middleware(__dirname + '/public') #makes css files from stylus
app.use express.static(path.join(__dirname, 'public')) #static files

# development only
if 'development' == app.get('env')
  app.use express.errorHandler()

(require './routes') app

http.createServer(app).listen app.get('port'), () ->
  console.log('Express server listening on port ' + app.get('port'));
