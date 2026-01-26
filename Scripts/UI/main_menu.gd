extends Control

func _on_start_pressed() -> void:
	Transitions.change_scene("res://Scenes/game.tscn", "swipe")

func _on_options_pressed() -> void:
	Transitions.change_scene("res://Scenes/UI/options.tscn", "fade")

func _on_test_place_pressed() -> void:
	Transitions.change_scene("res://Scenes/Stages/testing.tscn", "fade")

func _on_quit_pressed() -> void:
	get_tree().quit()
