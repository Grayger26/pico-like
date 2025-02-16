extends Area2D

@onready var deliver_label: Label = $DeliverLabel

var can_deliver = true

@export var mail_game : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		if can_deliver:
			deliver_label.visible = true
		if body.in_delivery_zone != null:
			body.in_delivery_zone = true
	


func _on_body_exited(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		deliver_label.visible = false
		if body.in_delivery_zone != null:
			body.in_delivery_zone = false


func _unhandled_input(event: InputEvent) -> void:
	if can_deliver and deliver_label.visible == true and Input.is_action_just_pressed("z"):
		#get_tree().paused = true
		get_tree().get_first_node_in_group("Guy").set_physics_process(false)
		get_tree().get_first_node_in_group("Guy").set_process(false)
		var deliver_game = mail_game.instantiate()
		var canvas_layer = get_tree().get_first_node_in_group("CanvasLayer")
		canvas_layer.add_child(deliver_game)
		deliver_label.visible = false
		can_deliver = false
		$Timer.start()


func _on_timer_timeout() -> void:
	can_deliver = true
