extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var bullet_scene : PackedScene
var fire_rate : Array = [1, 2, 4, 6]
@onready var timer: Timer = $Timer
var is_shooting = false
var bullet_texture = 0
var posstible_bullet_textures = [0, 1, 2, 3]
@onready var marker_2d: Marker2D = $Marker2D
@onready var mail_game: Node2D = get_tree().get_first_node_in_group("mail_game")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = fire_rate.pick_random()
	bullet_texture = posstible_bullet_textures.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	shoot()


func shoot():
	is_shooting = true 
	animation_player.play("shoot")
	$shoot_sfx.play()
	await animation_player.animation_finished 

	var bullet = bullet_scene.instantiate()
	mail_game.add_child(bullet)
	bullet.global_position = marker_2d.global_position
	
	bullet.sprite_2d.frame = bullet_texture

	timer.start()
	is_shooting = false
	animation_player.play("idle")
	
