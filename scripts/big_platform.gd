extends AnimatableBody2D

var direction : Vector2 = Vector2.LEFT

var directions : Array = [Vector2.LEFT,  Vector2.RIGHT]
var dir = "left"
var speed : int
var speed_levels = [7, 10, 12, 15, 17, 20]

@export var GUN : PackedScene

var with_gun : bool
var with_gun_choice = [true, false]
var num_of_guns = 1
var possible_num_of_guns = [1, 2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = directions.pick_random()
	if direction == Vector2.LEFT:
		dir = "left"
	else:
		dir = "right"
	
	speed = speed_levels.pick_random()
	with_gun = with_gun_choice.pick_random()
	
	num_of_guns = possible_num_of_guns.pick_random()
	
	if with_gun:
		if num_of_guns == 1:
			add_one_gun()
		elif num_of_guns == 2:
			add_two_guns()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if dir == "left":
		dir = "right"
		direction = Vector2.RIGHT
	elif dir == "right":
		dir = "left"
		direction = Vector2.LEFT

func add_one_gun():
	var gun = GUN.instantiate()
	gun.position = $Marker2D3.position
	$Marker2D3.add_child(gun)

func add_two_guns():
	var gun = GUN.instantiate()
	gun.position = $Marker2D.position
	$Marker2D.add_child(gun)
	var gun2 = GUN.instantiate()
	gun2.position = $Marker2D2.position
	$Marker2D2.add_child(gun2)
