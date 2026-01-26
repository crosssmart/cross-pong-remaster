extends CharacterBody2D

var player_speed : int = 400
var start_pos : Vector2 = Vector2(-850, 0)


func _ready() -> void :
	self.position = start_pos
	
func _process(delta: float) -> void:
	player_move(delta)
	limit_player()

func player_move(_delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_W):
		position.y -= player_speed * _delta
	elif Input.is_key_pressed(KEY_S):
		position.y += player_speed * _delta

func limit_player() -> void:
	position.y = clamp(position.y, -290, 390)
