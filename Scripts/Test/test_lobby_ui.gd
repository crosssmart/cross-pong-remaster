extends Control

@onready var select_mode: Control = $selectMode
@onready var match_prepare: Control = $matchPrepare
@onready var text_p_1: RichTextLabel = $matchPrepare/HBoxContainer/readyP1
@onready var text_p_2: RichTextLabel = $matchPrepare/HBoxContainer/readyP2
@onready var timer: Timer = $matchPrepare/Timer
@onready var start_time: RichTextLabel = $matchPrepare/HBoxContainer/start_time
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var test_game_manager: Node2D = $"../.."

var modeTypes : Array = ["2Player", "Bot"]
var mode : String
var selected : bool = false

# Condições se está preparado
var p1_ready : bool = false
var p2_ready : bool = false

func _ready() -> void:
	match_prepare.hide()
	select_mode.show()
	
	if self.visible == false :
		self.show()
		if match_prepare.visible == true:
			match_prepare.hide()
		elif select_mode.visible == false:
			select_mode.show()
	

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		start_time.text = str(int(timer.time_left))
	elif timer.is_stopped() and mode != "start" :
		start_time.text = "Vai começar... eventualmente..."
	
	#Quando selecionado verifica qual foi escolhido
	if selected :
		match mode :
			"2Player" :
				select_mode.hide()
				match_prepare.show()
				if p1_ready and p2_ready and timer.is_stopped():
					timer.start(4)
				elif not p1_ready or not p2_ready  :
					timer.stop() 
					pass
			
			"Bot" :
				#Tenho que codar ainda o bot
				pass
		
		if Input.is_action_just_pressed("confirm_p1") :
			p1_ready = !p1_ready
			text_p_1.text = "Ready" if p1_ready else "Not Ready"
			
		if Input.is_action_just_pressed("confirm_p2") :
			p2_ready = !p2_ready
			text_p_2.text = "Ready" if p2_ready else "Not Ready"


# 2 jogadores
func _on_p_pressed() -> void:
	mode = modeTypes[0]
	selected = true

# Bot mode
func _on_bot_pressed() -> void:
	mode = modeTypes[1]
	selected = true

#Timer acabou
func _on_timer_timeout() -> void:
	animation_player.play("fade_out")
	mode = "start"
	start_time.text = ""
	
	await animation_player.animation_finished
	test_game_manager.startGame()
