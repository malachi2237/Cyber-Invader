extends LevelPhase

class_name DialoguePhase

export var dialogue_node: NodePath

export (Array, PackedScene) var character_frames

onready var dialogue: Dialogue = get_node(dialogue_node)

onready var frame_instances: Array = []

var dialogue_started = false

var player: Player = null

var current_frame: DialogueFrame

func _ready():
	var hud_layer = Utility.get_hud_layer(self)
	
	build_character_frames(hud_layer)
	set_dialogue_names()
	
	player = Utility.get_player(self)
	
	if start_delay <= 0:
		start_phase()

func build_character_frames(hud_layer):
	for frame in character_frames:
		var instance = frame.instance() as DialogueFrame
		if instance is DialogueFrame:
			frame_instances.append(instance)
			instance.hide()
		
			#Mutation
			if hud_layer: hud_layer.add_child(instance)
			else: Utility.placeInScene(self, instance, null)

func set_dialogue_names():
	for i in range(frame_instances.count(DialogueFrame)):
		var frame: DialogueFrame = frame_instances[i] as DialogueFrame
		frame.set_name(dialogue.characters[i])

func start_phase():
	var gm = Utility.get_game_manager(self)
	if gm is GameManager:
		gm.wipe_enemies()
	
	if player:
		player.pause_input(true)
	
	dialogue_started = true
	
	_advance_dialogue()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and dialogue_started:
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
	var character_num = dialogue.characters.find(name)
	if character_num == -1: return null
	return frame_instances[character_num]

	
func _end_phase():
	._end_phase()
	#Mutative
	for frame in frame_instances:
		frame.queue_free()
	if player:
		player.pause_input(false)
	queue_free()
