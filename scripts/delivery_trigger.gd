extends Area2D

@onready var deliver_label: Label = $DeliverLabel
@onready var main_ui: Control = $"../../CanvasLayer/MainUI"


var can_deliver = true

@export var mail_game : PackedScene

@onready var timer_label: Label = $TimerLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]


func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		if can_deliver:
			main_ui.x.visible = true
			deliver_label.visible = true
			timer_label.visible = false
		elif !can_deliver:
			timer_label.visible = true
		if body.in_delivery_zone != null:
			body.in_delivery_zone = true
	


func _on_body_exited(body: Node2D) -> void:
	if get_tree().get_first_node_in_group("Guy") != null and body == get_tree().get_first_node_in_group("Guy"):
		main_ui.x.visible = false
		deliver_label.visible = false
		timer_label.visible = false
		if body.in_delivery_zone != null:
			body.in_delivery_zone = false


func _unhandled_input(event: InputEvent) -> void:
	if can_deliver and deliver_label.visible == true and Input.is_action_just_pressed("x"):
		#get_tree().paused = true
		get_tree().get_first_node_in_group("Guy").set_physics_process(false)
		get_tree().get_first_node_in_group("Guy").set_process(false)
		var deliver_game = mail_game.instantiate()
		var canvas_layer = get_tree().get_first_node_in_group("CanvasLayer")
		canvas_layer.add_child(deliver_game)
		deliver_label.visible = false
		can_deliver = false
		get_tree().get_first_node_in_group("bg_music").stream_paused = true
		$Timer.start()


func _on_timer_timeout() -> void:
	can_deliver = true
