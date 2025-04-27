extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.5).timeout
	get_node("TitleAnimated").show()
	get_node("TitleAnimated").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_title_animated_animation_finished():
	get_node("Menu").show()
	get_node("MusicMenu").play()

func _on_music_menu_finished():
	get_node("MusicMenu").play()

func _on_button_play_mouse_entered():
	get_node("Menu/SoundBarAnimated").play()
	get_node("Menu/MenuBarAnimated").position.y = 123
	get_node("Menu/MenuBarAnimated").show()
	get_node("Menu/MenuBarAnimated").play()
	get_node("Menu/Play/LabelPlay").modulate = Color(1, 1, 1, 1)

func _on_button_play_mouse_exited():
	get_node("Menu/MenuBarAnimated").hide()
	get_node("Menu/Play/LabelPlay").modulate = Color(0, 0, 0, 1)
	
func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scene/introduction.tscn")

################################################################################

func _on_button_save_mouse_entered():
	get_node("Menu/SoundBarAnimated").play()
	get_node("Menu/MenuBarAnimated").position.y = 220
	get_node("Menu/MenuBarAnimated").show()
	get_node("Menu/MenuBarAnimated").play()
	get_node("Menu/Save/LabelSave").modulate = Color(1, 1, 1, 1)

func _on_button_save_mouse_exited():
	get_node("Menu/MenuBarAnimated").hide()
	get_node("Menu/Save/LabelSave").modulate = Color(0, 0, 0, 1)

func _on_button_save_pressed():
	pass # Replace with function body.

################################################################################

func _on_button_option_mouse_entered():
	get_node("Menu/SoundBarAnimated").play()
	get_node("Menu/MenuBarAnimated").position.y = 328
	get_node("Menu/MenuBarAnimated").show()
	get_node("Menu/MenuBarAnimated").play()
	get_node("Menu/Option/LabelOption").modulate = Color(1, 1, 1, 1)

func _on_button_option_mouse_exited():
	get_node("Menu/MenuBarAnimated").hide()
	get_node("Menu/Option/LabelOption").modulate = Color(0, 0, 0, 1)

func _on_button_option_pressed():
	pass # Replace with function body.

################################################################################

func _on_button_quit_mouse_entered():
	get_node("Menu/SoundBarAnimated").play()
	get_node("Menu/MenuBarAnimated").position.y = 433
	get_node("Menu/MenuBarAnimated").show()
	get_node("Menu/MenuBarAnimated").play()
	get_node("Menu/Quit/LabelQuit").modulate = Color(1, 1, 1, 1)

func _on_button_quit_mouse_exited():
	get_node("Menu/MenuBarAnimated").hide()
	get_node("Menu/Quit/LabelQuit").modulate = Color(0, 0, 0, 1)

func _on_button_quit_pressed():
	get_tree().quit()

