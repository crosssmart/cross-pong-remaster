extends Area2D

@onready var gameHandler = get_parent()
@onready var animation = get_node("AnimationPlayer")
@onready var sprite: Sprite2D = $Sprite2D
@export var min_ball_speed : int

var ball_speed : int
var initial_pos : Vector2 = Vector2(960, 540)
var initial_direction: Vector2 = Vector2(0, 0)
var new_direction: Vector2 = Vector2(0, 0)


var y_min : float = 160
var y_max : float = 1030

func _ready() -> void:
	self.show()
	ball_reset()

func _process(delta: float) -> void:
	# Processa movimentação constante e as colisões
	ball_movement(delta)
	wall_collision()


#Supostamente resetar a bola
func ball_reset() -> void :
	ball_speed = 300
	
	# Posição volta a ser a inicial
	position = initial_pos
	
	# E ja escolhe a direção
	# choose_initial_direction()


func choose_initial_direction() -> void:
	# Escolhe as direções horizontal e  Verticalmente
	var y_random = [-1,1].pick_random()
	var x_random = [-1,1].pick_random()
	
	# Aplica as novas direções
	initial_direction = Vector2(x_random, y_random)
	
	if(x_random < 0):
		animation.play_backwards("roll")
	elif(x_random > 0):
		animation.play("roll")
	
	new_direction = initial_direction


# Movimentação constante
func ball_movement(delta : float) -> void:
	position += new_direction * ball_speed * delta


# Colisão com paredes no caso teto e chão
# Mudando o valor de y
func wall_collision() -> void:
	if position.y >= y_max or position.y <= y_min:
		new_direction.y *= -1


# Colisão com os jogadores
# Muda o valor de x
func _on_body_entered(body: Node2D):
	if body.is_in_group("Players"):
		new_direction.x *= -1
		#Ball speed changes after 3 touches?
		gameHandler.touchCount += 1
		
		#animation more speed
		animation.speed_scale += 0.2
		animation.speed_scale *= -1
