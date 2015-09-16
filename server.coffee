#!/usr/bin/env coffee

## Dependencies ################################################################

cheerio = require "cheerio"
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

## Minutecast ##

minutecastUrl = "http://www.accuweather.com/en/gb/york/yo30-7/" +
	"minute-weather-forecast/331608"
#minutecastUrl = "http://www.accuweather.com/en/gb/norwich/nr1-1/minute-weather-forecast/329791"
App.get "/pam/minutecast", ( req, res ) ->
	request minutecastUrl, ( err, code, data ) ->
		if err
			return

		$ = cheerio.load( data )
		output = { alert: "", segments: [] }

		output.alert = $( ".mc-summary > p" ).text()

		$( ".graphic > span" ).filter ->
			if @attribs.style == "background-color:#fff"
				output.segments.push ""
			else
				output.segments.push @attribs.style

		res.json( output )

## Start Server ################################################################

Server = App.listen 35000, ->
	console.log "Server Activated"
