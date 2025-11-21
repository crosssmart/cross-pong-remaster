extends CharacterBody2D

var player_speed : int = 300

func _process(delta: float) -> void:
	player_move(delta)
	limit_player()

func player_move(_delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_UP):
		position.y -= player_speed * _delta
	elif Input.is_key_pressed(KEY_DOWN):
		position.y += player_speed * _delta
		
func limit_player() -> void:
	position.y = clamp(position.y, -430, 390)
