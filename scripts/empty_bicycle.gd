extends StaticBody2D


@onready var label: Label = $Label
var can_ride = false

var GUY_ON_BICYCLE
var guy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GUY_ON_BICYCLE = load("res://characters/guy_on_bicycle.tscn")
	guy = get_tree().get_first_node_in_group("Guy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	guy = get_tree().get_first_node_in_group("Guy")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.in_delivery_zone == false:
		label.visible = true
		can_ride = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	label.visible = false
	can_ride = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("z") and guy.in_delivery_zone == false:
		if can_ride:
			can_ride = false
			var guy_on_bicycle = GUY_ON_BICYCLE.instantiate()
			get_parent().add_child(guy_on_bicycle)
			guy_on_bicycle.position = position
			guy = get_tree().get_first_node_in_group("Guy")
			guy.queue_free()
			queue_free()
