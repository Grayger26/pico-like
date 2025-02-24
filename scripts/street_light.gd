extends Node



func _on_time_system_updated(date_time : DateTime) -> void:
	var is_night := date_time.hours >= 21 or date_time.hours < 5
	
	for i in get_children():
		i.enabled = is_night
