## Date / Time #################################################################

$Date = $( "#date" )
$Time = $( "#time" )

dayNames = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
	"Friday", "Saturday" ]
monthNames = [ "January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December" ]

getOrdinal = ( n ) ->
	s = [ "th", "st" ,"nd", "rd" ]
	return s[ ( n % 100 - 20 ) % 10 ] or s[ n % 100 ] or s[ 0 ]

updateDateTime = ->
	now = new Date

	$Date.html(
		dayNames[ now.getDay() ] +
		", " +
		now.getDate() +
		"<sup>" +
		getOrdinal( now.getDate() ) +
		"</sup>" +
		" " +
		monthNames[ now.getMonth() ]
	)

	$Time.html(
		now.getHours() +
		":" +
		( if now.getMinutes() < 10 then "0" else "" ) +
		now.getMinutes() +
		"<span class='util-sub'>" +
		( if now.getHours() < 12 then "AM" else "PM" ) +
		"</span>"
	)

setInterval( updateDateTime, 1e3 )
updateDateTime()

## Weather #####################################################################

$Weather = $( "#weather" )

weatherIcons =
	"01d": "day-sunny"
	"01n": "night-clear"
	"02d": "day-cloudy"
	"02n": "night-cloudy"
	"03d": "cloud"
	"03n": "cloud"
	"04d": "cloudy"
	"04n": "cloudy"
	"09d": "sprinkle"
	"09n": "sprinkle"
	"10d": "rain"
	"10n": "rain"
	"11d": "lightning"
	"11n": "lightning"
	"13d": "snowflake-cold"
	"13n": "snowflake-cold"
	"50d": "fog"
	"50n": "fog"

round10 = ( n ) ->
	return Math.round( n * 10 ) / 10

updateWeather = ->
	$.getJSON "/pam/weather", ( data ) ->

		if not data?.weather?
			# Try again in a minute
			setTimeout( updateWeather, 60e3 )
			return

		$Weather.html(
			# Weather
			"<div class='block'>" +
			"<i class='wi wi-" +
			( weatherIcons[ data.weather[0].icon ] ? "na" ) +
			"'></i> " +
			data.weather[0].main +
			"</div><div class='block'>" +
			# Temperature
			round10( data.main.temp - 272.15 ) +
			"&deg;C" +
			"</div><div class='block'>" +
			# Wind Speed
			"<i style='transform: rotate( #{data.wind.deg}deg )' " +
			"class='wi wi-wind-direction'></i> " +
			round10( data.wind.speed * 2.23693629 ) + # convert m/s to mph
			"<span class='unit'>mph</span></div>"
		)

setInterval( updateWeather, 30 * 60e3 )
updateWeather()
