extends Node2D

@onready var light: DirectionalLight2D = $WorldLight
@onready var snow: GPUParticles2D = $CanvasLayer/Snow

@export var main_menu : PackedScene

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var guy: CharacterBody2D = $Guy
@onready var skis: StaticBody2D = $Skis



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	guy.position = Global.snow_start_pos
	skis.position = guy.position
	skis.position.x -= 15


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var light_color: Color = light.color
	var new_particle_color = light_color * Color(1.2, 1.2, 1.2, 1) # Сделать немного ярче

	if snow.process_material is ParticleProcessMaterial:
		snow.process_material.color = new_particle_color


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		var menu = main_menu.instantiate()
		canvas_layer.add_child(menu)

func _exit_tree() -> void:
	Global.snow_start_pos = Global.snow_village_pos_1
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
