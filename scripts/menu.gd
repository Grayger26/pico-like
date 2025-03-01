extends Control

@onready var focus: NinePatchRect = $Focus

@onready var play_button: Button = $PlayButton
@onready var quit_button: Button = $QuitButton

func _ready() -> void:
	focus.position = play_button.position

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("down") and focus.position == play_button.position:
		focus.position = quit_button.position
	if Input.is_action_just_pressed("up") and focus.position == quit_button.position:
		focus.position = play_button.position
	
	if Input.is_action_just_pressed("z") and focus.position == play_button.position:
		get_tree().paused = false
		queue_free()
	
	#if Input.is_action_just_pressed("z") and focus.position == quit_button.position:
		#await save_game()
		#get_tree().quit()



func save():
	var save_dict = {
		"coins" : Global.coins,
		"day" : Global.days,
		"hour" : Global.hours,
		"minutes" : Global.minutes,
	}
	return save_dict;

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_file:
		var save_data = save()
		save_file.store_string(JSON.stringify(save_data))
		save_file.close()
