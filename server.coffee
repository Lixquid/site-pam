#!/usr/bin/env coffee

## Dependencies ################################################################

express = require "express"
request = require "request"

App = express()
App.set "views", "#{__dirname}"
App.set "view engine", "jade"

## PAM #########################################################################

App.get "/pam", ( req, res ) ->
	res.render( "pam/index" )

## Weather ##

weatherUrl = "http://api.openweathermap.org/data/2.5/weather?id=2633352"
App.get "/pam/weather", ( req, res ) ->
	request weatherUrl, ( err, code, data ) ->
		if not err
			res.send( data )

## Start Server ################################################################

Server = App.listen 35000, ->
	console.log "Server Activated"
