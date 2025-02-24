extends CharacterBody2D

@export var max_speed: float = 120.0
@export var acceleration: float = 15.0
@export var deceleration: float = 40.0
@export var turn_speed: float = 30.0
@export var collision_slowdown: float = 0.3  # Насколько сильно замедляться при столкновении (30%)

var speed: float = 0.0
var first_movement: bool = true
var is_animating: bool = false  # Флаг блокировки смены анимаций

@onready var anim_player = $AnimationPlayer  # Кэшируем узел

func _ready():
	anim_player.animation_finished.connect(_on_animation_finished)

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# Движение вниз при наличии скорости
	if speed > 0:
		input_vector.y = 1  

	# Лево/право
	if Input.is_action_pressed("left"):
		input_vector.x = -1
	elif Input.is_action_pressed("right"):
		input_vector.x = 1

	# Разгон при нажатии "down"
	if Input.is_action_pressed("down") and not is_animating:
		if first_movement and speed == 0:
			play_animation("first_pull")
			first_movement = false
		else:
			play_animation("pull")

		speed = min(speed + acceleration, max_speed)

	# Торможение при зажатии "up"
	if Input.is_action_pressed("up"):
		speed = max(speed - deceleration * delta, 0)

	# Проверяем столкновение
	var previous_velocity = velocity  # Сохраняем прошлое движение
	velocity = input_vector.normalized() * speed

	var collision = move_and_slide()

	if collision:  # Если произошло столкновение
		speed *= collision_slowdown  # Замедляем скорость на 30%, но не останавливаем
		velocity = previous_velocity * collision_slowdown  # Сохраняем направление, но уменьшаем скорость

	# Если анимация не заблокирована, переключаемся на "free_ride" или "idle"
	if not is_animating:
		if speed > 0:
			play_animation("free_ride")
		else:
			play_animation("idle")
			first_movement = true  # Позволяем снова проигрывать first_pull

func play_animation(anim_name):
	if anim_player.current_animation != anim_name:
		anim_player.play(anim_name)
		if anim_name in ["first_pull", "pull"]:
			is_animating = true  # Блокируем смену анимаций, но не движение

func _on_animation_finished(anim_name):
	if anim_name in ["first_pull", "pull"]:
		is_animating = false  # Разрешаем смену анимаций
