extends Control


@onready var highscore_panel: NinePatchRect = $HighscorePanel
@onready var time_label: Label = $TimePanel/Time
@onready var highscore_label: Label = $HighscorePanel/HighscoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highscore_label.text = Global.highscore_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
