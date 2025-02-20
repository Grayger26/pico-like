extends DirectionalLight2D

@export var day_color : Color
@export var night_color : Color
@export var morning_color : Color
@export var evening_color : Color
@export var day_start : DateTime
@export var night_start : DateTime
@export var morning_start : DateTime
@export var evening_start : DateTime
@export var transition_time : int = 30 # in minutes
@export var time_system : TimeSystem

var in_transition : bool = false

enum DayState {MORNING, DAY, EVENING, NIGHT}
var current_state : DayState = DayState.DAY

func _ready() -> void:
	var diff_morning_start = time_system.date_time.diff_without_days(morning_start)
	var diff_day_start = time_system.date_time.diff_without_days(day_start)
	var diff_evening_start = time_system.date_time.diff_without_days(evening_start)
	var diff_night_start = time_system.date_time.diff_without_days(night_start)

	if diff_night_start > 0 || (diff_evening_start > 0 and diff_night_start <= 0):
		current_state = DayState.NIGHT
	elif diff_evening_start <= 0 and diff_day_start > 0:
		current_state = DayState.EVENING
	elif diff_day_start <= 0 and diff_morning_start > 0:
		current_state = DayState.DAY
	else:
		current_state = DayState.MORNING

@onready var time_map : Dictionary = {
	DayState.MORNING: morning_start,
	DayState.DAY: day_start,
	DayState.EVENING: evening_start,
	DayState.NIGHT: night_start
}

@onready var transition_map : Dictionary = {
	DayState.MORNING: DayState.DAY,
	DayState.DAY: DayState.EVENING,
	DayState.EVENING: DayState.NIGHT,
	DayState.NIGHT: DayState.MORNING
}

@onready var color_map : Dictionary = {
	DayState.MORNING: morning_color,
	DayState.DAY: day_color,
	DayState.EVENING: evening_color,
	DayState.NIGHT: night_color
}

func update(game_time : DateTime):
	var next_state = transition_map[current_state]
	var change_time = time_map[next_state]
	var time_diff = change_time.diff_without_days(game_time)
	
	if in_transition:
		update_transition(time_diff, next_state)
	elif time_diff > 0 and time_diff < (transition_time * 60):
		in_transition = true
		update_transition(time_diff, next_state)
	else:
		color = color_map[current_state]

func update_transition(time_diff : int, next_state : DayState):
	var ratio = 1 - (time_diff as float / (transition_time * 60))
	if ratio > 1:
		current_state = next_state
		in_transition = false
	else:
		color = color_map[current_state].lerp(color_map[next_state], ratio)
