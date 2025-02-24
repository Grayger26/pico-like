extends Area2D


@onready var canvas_layer: CanvasLayer = $"../../CanvasLayer"
@onready var main_ui: Control = $"../../CanvasLayer/MainUI"

@onready var label: Label = $Label

@export var home_scene : PackedScene

func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		main_ui.x.visible = true
		label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		main_ui.x.visible = false
		label.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if label.visible == true and Input.is_action_just_pressed("x"):
		get_tree().get_first_node_in_group("Guy").set_physics_process(false)
		get_tree().get_first_node_in_group("Guy").set_process(false)
		var home = home_scene.instantiate()
		var canvas_layer = get_tree().get_first_node_in_group("CanvasLayer")
		canvas_layer.add_child(home)
		label.visible = false
