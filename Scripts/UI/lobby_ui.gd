extends Control

var p1Ready : bool = false 
var p2Ready : bool = false 
var counting : bool = false  # evita vários timers ao mesmo tempo

@onready var timer_tempo: Timer = $Timer
@onready var p1_text: RichTextLabel = $HBoxContainer/P1_text
@onready var p2_text: RichTextLabel = $HBoxContainer/P2_text
@onready var timer: RichTextLabel = $HBoxContainer/Timer

func _ready() -> void:
	await get_tree().create_timer(0.3).timeout
	Engine.time_scale = 0
	show()
	timer.hide()

func _process(_delta: float) -> void:
	timer.text = str(timer_tempo.time_left)
	# Ambos prontos? -> inicia contagem
	if p1Ready and p2Ready:
		timer.show()

		if not counting:
			counting = true
			start_countdown()  # <<< inicia a função async

	else:
		# Se alguém DESmarcar ready → resetar
		counting = false
		timer.hide()

	# Player 1 toggle
	if Input.is_action_just_pressed("confirm_p1"):
		p1Ready = !p1Ready
		p1_text.text = "READY" if p1Ready else "NOT READY"

	# Player 2 toggle
	if Input.is_action_just_pressed("confirm_p2"):
		p2Ready = !p2Ready
		p2_text.text = "READY" if p2Ready else "NOT READY"

func start_countdown() -> void:
	timer_tempo.start(10)
	print("chgou aqui 1")
	print("chgou aqui")
	print(timer_tempo.time_left)
	await timer_tempo.is_stopped()
	
	
	timer.text = str(timer_tempo.wait_time)
	initGame()
	#

func initGame() -> void:
	hide()
	Engine.time_scale = 1
	
func _on_timer_timeout() -> bool:
	print("foi")
	return true
