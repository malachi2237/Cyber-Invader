extends Control

class_name DialogueFrame

onready var _character_name = $DialogueBox/Name
onready var _display_text = $DialogueBox/Text

func set_name(name: String):
	_character_name.text = name
	
func set_dialogue(text: String):
	_display_text = text
