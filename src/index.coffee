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
render = (req, res) ->
    res.render "index.pug", req.params

app.get '/', render
app.get '/:gender/:age/:height/:weight/', render
app.get '/:gender/:age/:height/:weight', render
app.get '/:gender/:age/:height/', render
app.get '/:gender/:age/:height', render
app.get '/:gender/:age/', render
app.get '/:gender/:age', render
app.get '/:gender/', render
app.get '/:gender', render

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