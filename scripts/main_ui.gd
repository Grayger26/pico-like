extends Control

@onready var day_label: Label = $TimeControl/DayLabel
@onready var hours_label: Label = $TimeControl/HoursLabel
@onready var minutes_label: Label = $TimeControl/MinutesLabel

@onready var z: NinePatchRect = $HintControl/Z
@onready var x: NinePatchRect = $HintControl/X

@onready var coin_label: Label = $CoinControl/CoinLabel


func _process(delta: float) -> void:
	if Global.coins > 9999999:
		coin_label.text = str(9999999)
	else:
		coin_label.text = str(Global.coins)


func _on_time_system_updated(date_time : DateTime) -> void:
	update_label(day_label, date_time.days, false)
	update_label(hours_label, date_time.hours)
	update_label(minutes_label, date_time.minutes)



func add_leading_zero(label : Label, value : int):
	if value < 10:
		label.text += '0'

func update_label(label : Label, value : int, should_have_zero : bool = true):
	label.text = ""
	
	if should_have_zero:
		add_leading_zero(label, value)
	
	label.text += str(value)
