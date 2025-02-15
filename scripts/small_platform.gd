extends AnimatableBody2D

var direction : Vector2 = Vector2.LEFT

var directions : Array = [Vector2.LEFT,  Vector2.RIGHT]
var dir = "left"
var speed : int
var speed_levels = [7, 10, 12, 15, 17, 20]

@export var GUN : PackedScene

var with_gun : bool
var with_gun_choice = [true, false]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = directions.pick_random()
	if direction == Vector2.LEFT:
		dir = "left"
	else:
		dir = "right"
	
	speed = speed_levels.pick_random()
	with_gun = with_gun_choice.pick_random()
	
	if with_gun:
		add_gun()


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

func add_gun():
	var gun = GUN.instantiate()
	gun.position = position
	self.add_child(gun)
