extends Node

func change_scene(target: String, type: String) -> void:
	if type == "fade":
		transition_fade(target)
	elif type == "swipe":
		transition_swipe(target)
		
func transition_fade(target: String) -> void:
	$AnimationPlayer.play('fade')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('fade')

func transition_swipe(target: String) -> void:
	$AnimationPlayer.play('swipe')
	await get_tree().create_timer(0.25).timeout
	get_tree().change_scene_to_file(target)
