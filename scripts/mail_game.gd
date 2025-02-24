extends Node2D


@onready var win_window: Control = $MailgameUI/WinWindow
@onready var lose_window: Control = $MailgameUI/LoseWindow



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _exit_tree() -> void:
	get_tree().paused = false
	get_tree().get_first_node_in_group("bg_music").stream_paused = false
	get_tree().get_first_node_in_group("Guy").set_physics_process(true)
	get_tree().get_first_node_in_group("Guy").set_process(true)
	get_tree().get_first_node_in_group("Guy").in_delivery_zone = false
