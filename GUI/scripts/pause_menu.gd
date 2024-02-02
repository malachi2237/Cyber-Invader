extends Control

export(String, FILE, "*.tscn") var menu_scene: String

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		_toggle_pause()
		
func _toggle_pause():
	if is_visible():
		hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		show()

func _on_Resume_pressed():
	_toggle_pause()

func _on_Restart_pressed():
	_toggle_pause()
	var _toss = get_tree().reload_current_scene()

func _on_Main_Menu_pressed():
	_toggle_pause()
	var _toss = get_tree().change_scene(menu_scene)
