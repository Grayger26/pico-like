extends Control

@onready var hp_label: Label = $HpLabel
@onready var newspaper_label: Label = $NewspaperLabel

@onready var mail_guy: CharacterBody2D = $"../mailGuy"

@onready var win_window: Control = $WinWindow
@onready var lose_window: Control = $LoseWindow


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hp_label.text = str(mail_guy.hp)
	newspaper_label.text = str(mail_guy.newspaper_amount)

func _unhandled_input(event: InputEvent) -> void:
	if win_window.visible == true and Input.is_action_just_pressed("z"):
		get_tree().current_scene.queue_free()
	elif lose_window.visible == true and Input.is_action_just_pressed("z"):
		get_tree().current_scene.queue_free()
