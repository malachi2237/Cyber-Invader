extends LevelPhase

export var dialogue_node: NodePath

export var character_frame_a: PackedScene
export var character_frame_b: PackedScene

onready var dialogue: Dialogue = get_node(dialogue_node)

onready var frame_a: DialogueFrame = character_frame_a.instance()
onready var frame_b: DialogueFrame = character_frame_b.instance()

var current_frame: DialogueFrame

func _ready():
	var scene = Utility.getScene(self)
	
	frame_a.hide()
	frame_b.hide()
	
	Utility.placeInScene(scene, frame_a, null)
	Utility.placeInScene(scene, frame_b, null)

func advance_dialogue():
	var line = dialogue.consume_next_line()
	
	if not line:
		_end_phase()
		return
		
	var frame = get_frame(line.character_name)
	
	if frame:
		frame.set_dialogue(line.text)
		
		if frame.character_name != line.character_name:
			current_frame.hide()
			frame.show()
			current_frame = frame

func get_frame(name: String) -> Node:
	if name == dialogue.character_a:
		return frame_a
	elif name == dialogue.character_b:
		return frame_b
	
	return null

func _end_phase():
	._end_phase()
