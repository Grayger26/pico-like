extends Area2D

@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
var finish = false

@onready var skiing_ui: Control = $"../CanvasLayer/SkiingUI"





func _on_body_entered(body: Node2D) -> void:
	body.set_physics_process(false)
	finish = true
	$"../Timer".stop()
	skiing_ui.highscore_panel.visible = true
	update_highscore()

func _unhandled_input(event: InputEvent) -> void:
	if finish and Input.is_action_just_pressed("x"):
		get_tree().change_scene_to_file("res://scenes/snow.tscn")


func update_highscore():
	if Global.score < Global.highscore:
		Global.highscore = Global.score
		skiing_ui.highscore_label.text = skiing_ui.time_label.text
		Global.highscore_text = skiing_ui.time_label.text 
