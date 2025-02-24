extends Node2D

@export var main_menu : PackedScene
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var guy: CharacterBody2D = $Guy
@onready var change_to_snow_scene: Area2D = $SceneChangers/ChangeToSnowScene
@onready var empty_bicycle: StaticBody2D = $Empty_bicycle





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await load_game()
	guy.position = change_to_snow_scene.position
	guy.position.y += 15
	empty_bicycle.position = guy.position
	empty_bicycle.position.x = guy.position.x + 15
	empty_bicycle.position.y = guy.position.y + 15



func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		var menu = main_menu.instantiate()
		canvas_layer.add_child(menu)


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("Save file not found.")
		return

	var load_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	if load_file:
		var content = load_file.get_as_text()
		var save_data = JSON.parse_string(content) as Dictionary
		load_file.close()

		if save_data and save_data is Dictionary:
			Global.coins = save_data.get("coins", 0)
			Global.days = save_data.get("day", 1)
			Global.hours = save_data.get("hour", 0)
			Global.minutes = save_data.get("minutes", 0)
			Global.seconds = save_data.get("seconds", 0)
			Global.highscore = save_data.get("skiing highscore", 0)
			Global.highscore_text = save_data.get("highscore_text", 0)

			# Если TimeSystem уже существует, обнови date_time напрямую
			if has_node("TimeSystem"):
				var time_system = get_node("TimeSystem") as TimeSystem
				time_system.date_time.days = Global.days
				time_system.date_time.hours = Global.hours
				time_system.date_time.minutes = Global.minutes
				time_system.date_time.seconds = Global.seconds
				print("Updated TimeSystem from loaded data.")

			print("Loaded data:", save_data)


func _exit_tree() -> void:
	await save_game()


func save():
	var save_dict = {
		"coins" : Global.coins,
		"day" : Global.days,
		"hour" : Global.hours,
		"minutes" : Global.minutes,
		"skiing highscore" : Global.highscore,
		"highscore_text" : Global.highscore_text
	}
	return save_dict;

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if save_file:
		var save_data = save()
		save_file.store_string(JSON.stringify(save_data))
		save_file.close()
