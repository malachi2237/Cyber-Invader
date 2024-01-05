extends Control

export(PackedScene) var game_scene: PackedScene
func _ready() -> void:
	pass

func _on_Start_pressed() -> void:
	var _a = get_tree().change_scene_to(game_scene)
