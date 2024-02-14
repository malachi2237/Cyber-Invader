extends ColorRect

export(String, FILE, "*.tscn") var menu_scene: String

onready var ScoreText = $CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/Label2

func update_score(score: float):
	ScoreText.text = "%s" % score


func _on_Restart_pressed():
	var _toss = get_tree().reload_current_scene()


func _on_Main_Menu_pressed():
	var _toss = get_tree().change_scene(menu_scene)
