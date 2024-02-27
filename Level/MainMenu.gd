extends Control

export(PackedScene) var game_scene: PackedScene
export(PackedScene) var tutorial_scene: PackedScene
export(PackedScene) var credits_scene: PackedScene

onready var start_button = $HudLayer/Start
onready var tutorial_button = $HudLayer/Tutorial
onready var credits_button = $HudLayer/Credits

func _ready() -> void:
	pass

func _on_Start_pressed() -> void:
	var _a = get_tree().change_scene_to(game_scene)

func _on_How_To_Play_pressed():
	var dialogue: DialoguePhase = tutorial_scene.instance()

	disable_buttons()
	var _toss = dialogue.connect("phase_ended", self, "enable_buttons")
	Utility.placeInScene(self, dialogue, null)

func disable_buttons():
	start_button.disabled = true
	tutorial_button.disabled = true
	credits_button.disabled = true

func enable_buttons():
	start_button.disabled = false
	tutorial_button.disabled = false
	credits_button.disabled = false
	
func _on_Credits_pressed():
	var _a = get_tree().change_scene_to(credits_scene)
