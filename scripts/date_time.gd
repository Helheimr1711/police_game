#extends Resource
#class_name DateTime
#
#@export_range(0, 59) var seconds: int = 0
#@export_range(0, 59) var minutes: int = 0
#@export_range(0, 23) var hours: int = 0
#@export var days: int = 1
#@export_range(1, 12) var months: int = 1
#@export var years: int = 2021
#
#var delta_time: float = 0
#
#var months_info = {
	#1: {"Name": "January", "Days": 31},
	#2: {"Name": "February", "Days": 28},
	#3: {"Name": "March", "Days": 31},
	#4: {"Name": "April", "Days": 30},
	#5: {"Name": "May", "Days": 31},
	#6: {"Name": "June", "Days": 30},
	#7: {"Name": "July", "Days": 31},
	#8: {"Name": "August", "Days": 31},
	#9: {"Name": "September", "Days": 30},
	#10: {"Name": "October", "Days": 31},
	#11: {"Name": "November", "Days": 30},
	#12: {"Name": "December", "Days": 31}
#}
#
#
#func increase_by_secs(delta_seconds: float) -> void:
	#delta_time += delta_seconds
	#if delta_time < 1: return
	#
	#var delta_int_seconds: int = delta_time
	#delta_time -= delta_int_seconds
	#
	#seconds += delta_int_seconds
	#minutes += seconds / 60
	#hours += minutes / 60
	#days += hours / 24
	#months += days / months_info[months]["Days"]
	#years += months / 12
	#
	#seconds = seconds % 60
	#minutes = minutes % 60
	#hours = hours % 24
	#days = days % months_info[months]["Days"]
	#months = months % 12
	#
	#print_debug(str(years) + ":" + str(months) + ":" + str(days) + ":" + str(hours) + ":" + str(minutes) + ":" + str(seconds))
	
extends Resource
class_name DateTime

@export_range(0, 59) var seconds: int = 0
@export_range(0, 59) var minutes: int = 0
@export_range(0, 23) var hours: int = 0
@export_range(1, 31) var days: int = 1
@export_range(1, 12) var months: int = 1
@export var years: int = 2021

var delta_time: float = 0.0

var months_info = {
	1: {"Name": "January", "Days": 31},
	2: {"Name": "February", "Days": 28}, # Neřeší přestupné roky
	3: {"Name": "March", "Days": 31},
	4: {"Name": "April", "Days": 30},
	5: {"Name": "May", "Days": 31},
	6: {"Name": "June", "Days": 30},
	7: {"Name": "July", "Days": 31},
	8: {"Name": "August", "Days": 31},
	9: {"Name": "September", "Days": 30},
	10: {"Name": "October", "Days": 31},
	11: {"Name": "November", "Days": 30},
	12: {"Name": "December", "Days": 31}
}

func increase_by_secs(delta_seconds: float) -> void:
	delta_time += delta_seconds
	if delta_time < 1:
		return
	
	var delta_int_seconds: int = int(delta_time)
	delta_time -= delta_int_seconds

	# Přelévání hodnot
	seconds += delta_int_seconds
	if seconds >= 60:
		minutes += seconds / 60
		seconds = seconds % 60

	if minutes >= 60:
		hours += minutes / 60
		minutes = minutes % 60

	if hours >= 24:
		days += hours / 24
		hours = hours % 24

	while true:
		var max_days = months_info.get(months, {"Days": 31})["Days"]
		if days > max_days:
			days -= max_days
			months += 1
		else:
			break

	if months > 12:
		years += (months - 1) / 12
		months = (months - 1) % 12 + 1

	print_debug("%04d:%02d:%02d %02d:%02d:%02d" % [years, months, days, hours, minutes, seconds])
