extends Control

export(String, FILE, "*.tscn") var menu_scene: String

func _on_Button_pressed():
	var _toss = get_tree().change_scene(menu_scene)
