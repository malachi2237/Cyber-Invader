extends LevelPhase

class_name DialoguePhase

export var dialogue_node: NodePath

export var character_frame_a: PackedScene
export var character_frame_b: PackedScene

onready var dialogue: Dialogue = get_node(dialogue_node)

onready var frame_a: DialogueFrame = character_frame_a.instance()
onready var frame_b: DialogueFrame = character_frame_b.instance()

var player: Player = null

var current_frame: DialogueFrame

func _ready():
	var scene = Utility.getScene(self)
	
	frame_a.hide()
	frame_b.hide()
	
	Utility.placeInScene(scene, frame_a, null)
	Utility.placeInScene(scene, frame_b, null)
	
	frame_a.set_name(dialogue.character_a)
	frame_b.set_name(dialogue.character_b)
	
	player = Utility.get_player(self)
	
	start_phase()

func start_phase():
	player.set_process_input(false)
	player.set_process(false)
	_advance_dialogue()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		_advance_dialogue()

func _advance_dialogue():
	var line = dialogue.consume_next_line()
	
	if not line:
		_end_phase()
		return
		
	var frame = get_frame(line.character_name)
	
	if frame:
		frame.set_dialogue(line.text)
		
		if current_frame:
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
	frame_a.queue_free()
	frame_b.queue_free()
	player.set_process_input(true)
	player.set_process(true)
	queue_free()
