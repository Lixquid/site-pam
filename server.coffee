#!/usr/bin/env coffee

## Dependencies ################################################################

express = require "express"

App = express()
App.set "views", "#{__dirname}"
App.set "view engine", "jade"

## PAM #########################################################################

App.get "/pam", ( req, res ) ->
	res.render( "pam/index" )

## Start Server ################################################################

Server = App.listen 35000, ->
	console.log "Server Activated"
