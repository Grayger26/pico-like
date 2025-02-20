extends Node



func _on_time_system_updated(date_time : DateTime) -> void:
	if date_time.hours == 21:
		for i in get_children():
			i.enabled = true
	
	if date_time.hours == 5:
		for i in get_children():
			i.enabled = false
