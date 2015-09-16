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
		"<span class='sub'>" +
		( if now.getHours() < 12 then "AM" else "PM" ) +
		"</span>"
	)

setInterval( updateDateTime, 100 )
updateDateTime()
