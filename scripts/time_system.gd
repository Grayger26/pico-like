class_name TimeSystem extends Node

signal updated

@export var date_time : DateTime
@export var tics_per_second : int = 6


func _process(delta: float) -> void:
	date_time.increase_by_sec(tics_per_second * delta)
	updated.emit(date_time)
