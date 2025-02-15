extends CharacterBody2D


var speed = 15
var normal = 15
var slowed = 7
var gravel_speed = 18
var snow_trope_speed = 10
var ice_speed = 4

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wood_steps: AudioStreamPlayer2D = $"Sfx/wood steps"
@onready var grass_steps: AudioStreamPlayer2D = $"Sfx/grass steps"
@onready var dirt_steps: AudioStreamPlayer2D = $"Sfx/dirt steps"
@onready var concrete_steps: AudioStreamPlayer2D = $"Sfx/concrete steps"
@onready var sand_steps: AudioStreamPlayer2D = $"Sfx/sand steps"
@onready var gravel_steps: AudioStreamPlayer2D = $"Sfx/gravel steps"
@onready var snow_steps: AudioStreamPlayer2D = $"Sfx/snow steps"
@onready var ice_steps: AudioStreamPlayer2D = $"Sfx/ice steps"


var ground_tiles : TileMapLayer
var steps : AudioStreamPlayer2D

var step_is_playing = false

var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	animation_tree.active = true
	ground_tiles = get_tree().get_first_node_in_group("ground_tiles")
	steps = grass_steps


func _process(delta: float) -> void:
	sfx()
	update_animation_parameters()
	step_sound()


func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
	
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/run/blend_position"] = direction


func sfx():
	if direction != Vector2.ZERO:
		if not step_is_playing:
			steps.play()
			step_is_playing = true
	else:
		if step_is_playing:
			steps.stop()
			step_is_playing = false


func step_sound():
	var current_tile : Vector2i = ground_tiles.local_to_map(global_position)
	var tile_data : TileData = ground_tiles.get_cell_tile_data(current_tile)
	
	var ground_type = tile_data.get_custom_data("ground_type")
	
	if ground_type != null:
		match ground_type:
			"grass":
				if steps != grass_steps:
					steps.stop()
					step_is_playing = false
				steps = grass_steps
				speed = normal
			"dirt":
				if steps != dirt_steps:
					steps.stop()
					step_is_playing = false
				steps = dirt_steps
				speed = normal
			"wood":
				if steps != wood_steps:
					steps.stop()
					step_is_playing = false
				steps = wood_steps
				speed = normal
			"concrete":
				if steps != concrete_steps:
					steps.stop()
					step_is_playing = false
				steps = concrete_steps
				speed = normal
			"sand":
				if steps != sand_steps:
					steps.stop()
					step_is_playing = false
				steps = sand_steps
				speed = normal
			"gravel":
				if steps != gravel_steps:
					steps.stop()
					step_is_playing = false
				steps = gravel_steps
				speed = normal
			"snow":
				if steps != snow_steps:
					steps.stop()
					step_is_playing = false
				steps = snow_steps
				speed = slowed
			"snow_trope":
				if steps != snow_steps:
					steps.stop()
					step_is_playing = false
				steps = snow_steps
				speed = snow_trope_speed
			"ice":
				if steps != ice_steps:
					steps.stop()
					step_is_playing = false
				steps = ice_steps
				speed = ice_speed
		
