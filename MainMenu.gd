extends Control

func _ready() -> void:
	pass

func _on_Start_pressed() -> void:
	var _a = get_tree().change_scene("res://GameScene.tscn")
