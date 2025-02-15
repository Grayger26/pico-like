extends AnimatedSprite2D

var speed = 20
var direction = Vector2.UP
var dir = "up"
@onready var wall_hit: AudioStreamPlayer2D = $wall_hit
@onready var trow_sound: AudioStreamPlayer2D = $trow_sound



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trow_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.collision_layer == 16:
		queue_free()
	elif body.collision_layer == 128 or body.collision_layer == 1:
		wall_hit.play()
		print(body)
		if dir == "down":
			dir = "up"
			direction = Vector2.UP
		elif dir == "up":
			dir = "down"
			direction = Vector2.DOWN
	
