extends CharacterBody2D


const GUY = preload("res://characters/guy.tscn")
var EMPTY_BICYCLE

var speed = 30
var acceleration = 1
var friction = 0.8
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@onready var ride: AudioStreamPlayer2D = $SFX/ride
@onready var ring: AudioStreamPlayer2D = $SFX/ring
@onready var stop: AudioStreamPlayer2D = $SFX/stop

var normal = 30
var sand_speed = 25
var gravel_speed = 40
var snow_speed = 8
var snow_trope_speed = 10
var ice_speed = 6
var concrete_speed = 48




var ride_is_playing = false

var direction : Vector2 = Vector2.ZERO

var ground_tiles : TileMapLayer


func _ready() -> void:
	EMPTY_BICYCLE = load("res://objects/empty_bicycle.tscn")
	animation_tree.active = true
	ground_tiles = get_tree().get_first_node_in_group("ground_tiles")


func _process(delta: float) -> void:
	print(speed)
	update_animation_parameters()
	ground_type()
	sfx()

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
		animation_tree["parameters/ride/blend_position"] = direction


func sfx():
	if direction != Vector2.ZERO:
		if not ride_is_playing:
			ride.play()
			ride_is_playing = true
	else:
		if ride_is_playing:
			ride.stop()
			stop.play()
			ride_is_playing = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("x"):
		ring.play()
	
	if Input.is_action_just_pressed("z"):
		var empty_bicycle = EMPTY_BICYCLE.instantiate()
		var guy = GUY.instantiate()
		get_parent().add_child(empty_bicycle)
		get_parent().add_child(guy)
		empty_bicycle.position = position
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
				speed = normal
			"dirt":
				speed = normal
			"wood":
				speed = normal
			"concrete":
				speed = concrete_speed
			"sand":
				speed = sand_speed
			"gravel":
				speed = gravel_speed
			"snow":
				speed = snow_speed
			"snow_trope":
				speed = snow_trope_speed
			"ice":
				speed = ice_speed
		
