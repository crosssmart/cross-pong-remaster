extends Node

@onready var animation := $AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> bool:
	return true
