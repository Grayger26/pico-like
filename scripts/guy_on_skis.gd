extends CharacterBody2D


const GUY = preload("res://characters/guy.tscn")

var speed = 30
var acceleration = 1
var friction = 0.8
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var normal = 30
var ground_speed = 3
var sand_speed = 2
var gravel_speed = 3
var snow_trope_speed = 40
var ice_speed = 18



var direction : Vector2 = Vector2.ZERO

var skis

var ground_tiles : TileMapLayer

func _ready() -> void:
	skis = load("res://objects/skis.tscn")
	ground_tiles = get_tree().get_first_node_in_group("ground_tiles")

func _process(delta: float) -> void:
	update_animation_parameters()
	ground_type()


func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		accelerate(direction)
		#velocity = direction * speed
	else:
		apply_friction()
		#velocity = Vector2.ZERO
	
	move_and_slide()

func accelerate(direction: Vector2):
	velocity = velocity.move_toward(speed * direction, acceleration)

func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)



func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
	
	if direction != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = direction
		animation_tree["parameters/move/blend_position"] = direction



func _unhandled_input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("z"):
		var empty_skis = skis.instantiate()
		var guy = GUY.instantiate()
		get_parent().add_child(empty_skis)
		get_parent().add_child(guy)
		empty_skis.position = position
		guy.position.x = position.x
		guy.position.y = position.y + 1
		queue_free()


func ground_type():
	var current_tile : Vector2i = ground_tiles.local_to_map(global_position)
	var tile_data : TileData = ground_tiles.get_cell_tile_data(current_tile)
	
	var ground_type = tile_data.get_custom_data("ground_type")
	
	if ground_type != null:
		match ground_type:
			"grass":
				speed = ground_speed
			"dirt":
				speed = ground_speed
			"wood":
				speed = ground_speed
			"concrete":
				speed = sand_speed
			"sand":
				speed = sand_speed
			"gravel":
				speed = gravel_speed
			"snow":
				speed = normal
			"snow_trope":
				speed = snow_trope_speed
			"ice":
				speed = ice_speed
		
