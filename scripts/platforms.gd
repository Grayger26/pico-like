extends Node2D

@export var small_platform : PackedScene
@export var big_platform : PackedScene
var platforms = []

@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var marker_2d_3: Marker2D = $Marker2D3
@onready var marker_2d_4: Marker2D = $Marker2D4

var markers = []

var num_of_platforms = 0
var possible_num_of_platforms = [0, 1, 2, 3, 4]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	markers.append(marker_2d)
	markers.append(marker_2d_2)
	markers.append(marker_2d_3)
	markers.append(marker_2d_4)
	
	
	num_of_platforms = possible_num_of_platforms.pick_random()
	
	if num_of_platforms > 0:
		for i in range(num_of_platforms):
			add_platform()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func add_platform():
	var random_plat: Node2D
	if randi() % 2 == 0:
		random_plat = small_platform.instantiate()
	else:
		random_plat = big_platform.instantiate()

	var random_marker = markers.pick_random()

	# Добавляем платформу в сцену
	self.add_child(random_plat)

	# Устанавливаем её позицию
	random_plat.global_position = random_marker.global_position

	# Удаляем использованный маркер
	markers.erase(random_marker)
	print(markers)
