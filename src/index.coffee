express   = require 'express'
pug       = require 'pug'
weblogger = require 'morgan'

app = global.pfc_app = express()
port = 1827

###
# Render settings
###
app.use express.static "#{__dirname}/public"
app.set 'views', "#{__dirname}/views"
app.set 'view engine', 'pug'

###
# Make sure to get the correct
# visitors' IP address
###
app.set 'trust proxy', 1

###
# Remove x-powered-by header
###
app.disable 'x-powered-by'

###
# Request information logger
###
app.use weblogger ':remote-addr - ":user-agent" - ":method :url HTTP/:http-version" :status - :response-time ms'

####################################

###
# Routes
###
app.get '/', (req, res) ->
    res.render "index.pug"

####################################

###
# Launch server
###
app.listen port, ->
    console.log "PFC web server listening on port #{port}"

###
# Last route: 404 Not Found
###
app.use (req, res, next) ->
    res.status 404
    res.send "404 Not Found: #{req.url}"