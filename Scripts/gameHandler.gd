extends Node

var ball_scene := preload("res://Scenes/Objects/ball.tscn")

@onready var scriptBall = $ball
@onready var speedText = $Camera2D/UI/speedText
@onready var pause_node = $Camera2D/UI/Pause
@onready var p1_text: RichTextLabel = $Camera2D/UI/P1_Points
@onready var p2_text: RichTextLabel = $Camera2D/UI/P2_Points

var paused : bool = false

var p1Points : int = 0
var p2Points : int = 0
var touchCount : int = 0

# Controle da animação do speedText
var last_speed := 0
var wave_time := 0.0   # duração do efeito de wave (em segundos)

func _process(delta: float) -> void:
	gameManager()
	speed_change(delta)
	
	# Pause
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

	# Velocity Change ao tocar
	if touchCount == 1:
		touchCount = 0
		scriptBall.ball_speed += 50

# Game
func gameManager() -> void :
	if (p1Points == 3) or (p2Points == 3) :
		Transitions.change_scene("res://Scenes/game.tscn","fade")

#Menu de pausa
func pauseMenu() :
	if paused :
		pause_node.hide()
		Engine.time_scale = 1
	else :
		pause_node.show()
		Engine.time_scale = 0
		
	paused = !paused

# Quando a bola deve modificar sua Velocidade
func speed_change(delta: float) -> void:
	var current_speed : int = scriptBall.ball_speed
	
	# Detecta mudança de velocidade → ativa a animação
	if current_speed != last_speed and current_speed != scriptBall.min_ball_speed:
		wave_time = 0.6  # dura 0.6s a animação wave
		last_speed = current_speed

	# Wave ativo?
	if wave_time > 0:
		wave_time -= delta
		speedText.text = "[wave amp=100 freq=20]" + str(round(current_speed / 10)) + "[/wave]"
	else:
		speedText.text = str(round(current_speed / 10))

# Reiniciar a bola só
func reload_obj() -> void:
	var parent = scriptBall.get_parent()
	var old_ball = scriptBall
	
	call_deferred("_finish_reload", parent, old_ball)

func _finish_reload(parent, old_ball) -> void:
	old_ball.queue_free()

	var new_ball = ball_scene.instantiate()
	new_ball.hide()
	new_ball.add_to_group("Ball")
	parent.add_child(new_ball)

	# Agora scriptBall aponta para a nova instância
	scriptBall = new_ball

#Colisões de pontuação
func _on_win_area_p_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball") :
		p2Points += 1
		p2_text.text = str(p2Points)
		reload_obj()

func _on_win_area_p_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ball") :
		p1Points += 1
		p1_text.text = str(p1Points)
		reload_obj()
