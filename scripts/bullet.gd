extends Area2D

var direction = Vector2.DOWN
var speed : int
var speed_levels : Array = [8, 10, 15, 20, 25]
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	speed = speed_levels.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.collision_layer == 1:
		body.animation_player_2.play("hurt")
		body.hurt_sound.play()
		body.hp -= 1
		queue_free()
	elif body.collision_layer == 16:
		queue_free()
