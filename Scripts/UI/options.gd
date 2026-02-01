extends Control
@onready var resolutions: OptionButton = $Panel/VBoxContainer/HBoxContainer3/resolutions


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_mute_check_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on)

func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
			center()
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
			center()
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
			center()

func _on_fullscreen_opt_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_back_pressed() -> void:
	Transitions.change_scene("res://Scenes/UI/main_menu.tscn", "swipe")

func center() -> void:
	var win := get_window()
	win.position = (DisplayServer.screen_get_size() - win.size) / 2
