extends Area2D

@onready var label: Label = $Label
@onready var main_ui: Control = $"../../CanvasLayer/MainUI"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	label.visible = true
	main_ui.x.visible = true


func _on_body_exited(body: Node2D) -> void:
	label.visible = false
	main_ui.x.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("x") and label.visible == true:
		get_tree().change_scene_to_file("res://scenes/village.tscn")
