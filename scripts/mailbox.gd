extends Area2D

var mailbox_color : String = "Red"
var colors : Array = ["Red", "Silver", "Pink", "Orange", "Light blue", "Green", "Dark blue", "Brown"]
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var collide_with_paper: CollisionShape2D = $AnimatableBody2D/CollisionShape2D


var state = "opened"

var score : int = 0
var level : int = 1

var levels : Array = [1, 2, 3, 4]

var speed = 5

@onready var timer: Timer = $Timer

var wait_time_array : Array = [1, 2, 3, 4, 5]
var timer_started = false

var dir = "right"
var direction = Vector2.RIGHT


@onready var win_window: Control = $"../MailgameUI/WinWindow"
@onready var coin_num_label: Label = $"../MailgameUI/WinWindow/WinPanel/CoinNumLabel"


var coins_for_player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins_for_player = Global.possible_coins
	mailbox_color = colors.pick_random()
	match mailbox_color:
		"Red":
			sprite_2d.texture = load("res://assets/mail game/red_mailbox.png")
		"Silver":
			sprite_2d.texture = load("res://assets/mail game/silver_mailbox.png")
		"Pink":
			sprite_2d.texture = load("res://assets/mail game/pink_mailbox.png")
		"Orange":
			sprite_2d.texture = load("res://assets/mail game/orange_mailbox.png")
		"Light blue":
			sprite_2d.texture = load("res://assets/mail game/light_blue_mailbox.png")
		"Green":
			sprite_2d.texture = load("res://assets/mail game/green_mailbox.png")
		"Dark blue":
			sprite_2d.texture = load("res://assets/mail game/dark_blue_mailbox.png")
		"Brown":
			sprite_2d.texture = load("res://assets/mail game/brown_mailbox.png")
		
	level = levels.pick_random()
	open()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match level:
		1:
			level_1()
		2:
			level_2()
		3:
			level_3(delta)
		4:
			level_4(delta)


func open():
	collide_with_paper.disabled = true
	state = "opened"
	sprite_2d.frame = 1
	collision_shape_2d.disabled = false

func close():
	collide_with_paper.disabled = false
	state = "closed"
	sprite_2d.frame = 0
	collision_shape_2d.disabled = true



func level_1():
	speed = 0
	open()

func level_2():
	speed = 0
	if !timer_started:
		timer_started = true
		timer.wait_time = wait_time_array.pick_random()
		timer.start()

func level_3(delta):
	speed = 5
	position += direction * speed * delta


func level_4(delta):
	speed = 5
	position += direction * speed * delta
	if !timer_started:
		timer_started = true
		timer.wait_time = wait_time_array.pick_random()
		timer.start()


func _on_timer_timeout() -> void:
	timer_started = false
	if state == "opened":
		close()
	else:
		open()


func _on_wall_detector_body_entered(body: Node2D) -> void:
	print(body)
	print(dir)
	if dir == "left":
		dir = "right"
		direction = Vector2.RIGHT
	elif dir == "right":
		dir = "left"
		direction = Vector2.LEFT
	


func _on_area_entered(area: Area2D) -> void:
	area.get_parent().queue_free()
	win()
	
func win():
	$WinSound.play()
	coin_num_label.text = str(coins_for_player)
	win_window.visible = true
	Global.coins += coins_for_player
	get_tree().paused = true
	
