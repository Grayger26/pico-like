class_name TimeSystem extends Node

signal updated

@export var date_time : DateTime
@export var tics_per_second : int = 6


func _ready() -> void:
	date_time.days = Global.days
	date_time.hours = Global.hours
	date_time.minutes = Global.minutes
	date_time.seconds = Global.seconds


func _process(delta: float) -> void:
	date_time.increase_by_sec(tics_per_second * delta)
	updated.emit(date_time)
	Global.days = date_time.days
	Global.hours = date_time.hours
	Global.minutes = date_time.minutes
	Global.seconds = date_time.seconds
