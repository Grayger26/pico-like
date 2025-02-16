extends CharacterBody2D

var speed = 15
var direction = Vector2.ZERO
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound


var can_throw = true
@export var newspaper : PackedScene
var is_throwing = false  # Флаг, чтобы не прерывать бросок
var newspaper_amount = 3
var rate = 2

var hp = 3

@onready var lose_window: Control = $"../MailgameUI/LoseWindow"


func _ready() -> void:
	# assign values to hp, speed, rate
	$ThrowTimer.wait_time = rate
	animation_player_2.play("normal")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left") and !Input.is_action_pressed("z") and !is_throwing:
		direction = Vector2.LEFT
	elif Input.is_action_pressed("right") and !Input.is_action_pressed("z") and !is_throwing:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if Input.is_action_just_pressed("z") and can_throw and newspaper_amount > 0:
		throw()


func _process(delta: float) -> void:
	animation()
	
	if hp <= 0:
		lose()
	
	if newspaper_amount <= 0:
		find_last_newspaper()
	

func animation():
	if is_throwing:
		return  # Не менять анимацию, если идёт бросок

	if Input.is_action_pressed("left") and !Input.is_action_pressed("z"):
		animation_player.play("move_left")
	elif Input.is_action_pressed("right") and !Input.is_action_pressed("z"):
		animation_player.play("move_right")
	else:
		animation_player.play("idle")

func throw():
	is_throwing = true 
	animation_player.play("throw")
	await animation_player.animation_finished 

	var paper = newspaper.instantiate()
	paper.global_position = $Marker2D.global_position
	$"..".add_child(paper)

	can_throw = false
	newspaper_amount -= 1
	$ThrowTimer.start()
	is_throwing = false  # Разрешаем переключение анимаций


func _on_throw_timer_timeout() -> void:
	can_throw = true


func lose():
	$LoseSound.play()
	get_tree().paused = true
	if lose_window != null:
		lose_window.visible = true

func find_last_newspaper():
	var last_paper = get_tree().get_first_node_in_group("newspaper")
	if last_paper == null:
		lose()
