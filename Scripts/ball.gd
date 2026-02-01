extends Area2D

@onready var gameHandler = get_parent()

var ball_speed : int = 300
var initial_pos : Vector2 = Vector2(960, 540)
var initial_direction: Vector2 = Vector2(0, 0)
var new_direction: Vector2 = Vector2(0, 0)

var y_min :float = 30
var y_max :float = 1000

func _ready() -> void:
	ball_reset()
	
func _process(delta: float) -> void:
	ball_movement(delta)
	wall_collision()

func ball_reset() -> void :
	position = initial_pos
	choose_initial_direction()
	
func choose_initial_direction() -> void:
	# Escolhe as direções horizontal e  Verticalmente
	var x_random = randf_range(-1,1)
	var y_random = randf_range(-1,1)
	
	#Aplica as novas direções
	initial_direction = Vector2(x_random, y_random)
	new_direction = initial_direction
	
	
func ball_movement(delta : float) -> void:
	position += new_direction * ball_speed * delta
	
func wall_collision() -> void:
	if position.y >= y_max or position.y <= y_min:
		new_direction.y *= -1

func _on_body_entered(body: Node2D):
	if body.is_in_group("Players"):
		new_direction.x *= -1
		#Ball speed changes after 3 touches
		gameHandler.touchCount += 1
