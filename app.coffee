# Module dependencies.

express = require 'express'
http = require 'http'
path = require 'path'
require 'coffee-script'

app = express()

# all environments
app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser('your secret here')
app.use express.session()
app.use app.router
app.use require('stylus').middleware(__dirname + '/public')
app.use express.static(path.join(__dirname, 'public'))

# development only
if 'development' == app.get('env')
  app.use express.errorHandler()

(require './routes/all') app

http.createServer(app).listen app.get('port'), () ->
  console.log('Express server listening on port ' + app.get('port'));

