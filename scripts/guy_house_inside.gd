extends Node2D

var player_can_exit = false
var player_can_sleep = false
var player_sleeps = false




func _on_exit_body_entered(body: Node2D) -> void:
	$Exit/Label.visible = true
	player_can_exit = true


func _on_exit_body_exited(body: Node2D) -> void:
	$Exit/Label.visible = false
	player_can_exit = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("z"):
		if player_can_exit:
			get_tree().change_scene_to_file("res://scenes/village.tscn")
		elif player_can_sleep and !player_sleeps:
			sleep()
		elif player_sleeps:
			wake_up()


func _on_sleep_body_entered(body: Node2D) -> void:
	$Sleep/Label.visible = true
	player_can_sleep = true


func _on_sleep_body_exited(body: Node2D) -> void:
	$Sleep/Label.visible = false
	player_can_sleep = false


func wake_up():
	$Sleep/Label.visible = true
	$Guy.visible = true
	$Guy.set_process(true)
	$Guy.set_physics_process(true)
	$SleepingGuy.visible = false
	player_sleeps = false

func sleep():
	$Guy.visible = false
	$Guy.set_process(false)
	$Guy.set_physics_process(false)
	$SleepingGuy.visible = true
	print($SleepingGuy.visible)
	player_sleeps = true
	$Sleep/Label.visible = false
