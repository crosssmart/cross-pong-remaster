extends Node2D

var player1_scene = preload("res://Scenes/Objects/player1.tscn")
var player2_scene = preload("res://Scenes/Objects/player2.tscn")

@onready var score_ui: Control = $Camera2D/TestScore
@onready var pause: Control = $Camera2D/Control_Pause/Pause

var paused : bool = false
var can_pause :bool = false


func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and can_pause:
		pauseMenu()

func _process(_delta: float) -> void:
	pass


func startGame() -> void :
	can_pause = true
	#Player
	var player = player1_scene.instantiate()
	add_child(player)
	player = player2_scene.instantiate()
	add_child(player)
	
	#Ui
	score_ui.show()
	
	
	#Bola

#Menu de pausa
func pauseMenu() :
	paused = !paused
	get_tree().paused = paused
	pause.visible = paused


# Controle da animação do speedText
#var last_speed := 0
#var wave_time := 0.0   # duração do efeito de wave (em segundos)

#func _process(delta: float) -> void:
#	gameManager()
#	speed_change(delta)
	
	# Pause
#	if Input.is_action_just_pressed("pause"):
#		pauseMenu()

	# Velocity Change ao tocar
#	if touchCount == 1:
#		touchCount = 0
#		scriptBall.ball_speed += 50

# Game
#func gameManager() -> void :
#	if (p1Points == 3) or (p2Points == 3) :
#		Transitions.change_scene("res://Scenes/game.tscn","fade")

#Menu de pausa
#func pauseMenu() :
#	if paused :
#		pause_node.hide()
#		Engine.time_scale = 1
#	else :
#		pause_node.show()
#		Engine.time_scale = 0
		
#	paused = !paused

# Quando a bola deve modificar sua Velocidade
##	var current_speed : int = scriptBall.ball_speed
#	
##	if current_speed != last_speed and current_speed != scriptBall.min_ball_speed:
#		wave_time = 0.6  # dura 0.6s a animação wave
#		last_speed = current_speed

	# Wave ativo?
#	if wave_time > 0:
#		wave_time -= delta
#		speedText.text = "[wave amp=100 freq=20]" + str(round(current_speed / 10)) + "[/wave]"
#	else:
#		speedText.text = str(round(current_speed / 10))

#Colisões de pontuação
#func _on_win_area_p_2_area_entered(area: Area2D) -> void:
#	if area.is_in_group("Ball") :
#		pass

#func _on_win_area_p_1_area_entered(area: Area2D) -> void:
#	if area.is_in_group("Ball") :
#		pass
