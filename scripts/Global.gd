extends Node



# player stats
var coins : int = 0

var player_position_in_village = Vector2(1000, 1000)
var player_position_in_snow

# mailman stats
var mailman_speed
var mailman_fire_rate
var mailman_hp
var newspaper_amount
var possible_coins = randi_range(1, 3)

# newspaper stats
var newspaper_speed


# Time
var days = 1
var hours = 6
var minutes = 30
var seconds = 0

var day_state


var snow_village_pos_1 : Vector2 = Vector2(492, 509)
var snow_village_pos_2 : Vector2 = Vector2(1224, 297)

var snow_start_pos : Vector2 = Vector2(492, 509)

var score = 0
var highscore = 1000
var highscore_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
