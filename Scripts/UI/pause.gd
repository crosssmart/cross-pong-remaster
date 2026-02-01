extends Control

var cena := PackedScene

func _ready() -> void:
	self.hide()

func _on_resume_pressed() -> void:
	$".".hide()
	get_tree().paused = false

func _on_reset_pressed() -> void:
	$".".hide()
	get_tree().paused = false
	Transitions.change_scene("res://Scenes/Stages/testing.tscn","swipe")

func _on_main_menu_pressed() -> void:
	$".".hide()
	get_tree().paused = false
	Transitions.change_scene("res://Scenes/UI/main_menu.tscn", "fade")
