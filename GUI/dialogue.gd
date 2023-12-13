extends Node

export(TextFile) var script_file: TextFile

var character_A: String = ""
var character_B: String = ""

var script_array: Array

func _ready():
	pass

func _process_file(file):
	var f = File.new()
	f.open(script_file, File.READ)
	
	if not f.eof_reached():
		var first_line = file.get_line()
		_read_character_list(first_line)
		
	while not f.eof_reached():
		var line = file.get

func _read_character_list(line):
	var name_indices: PoolIntArray
	var last_index = 0
		
	for i in range(2):
		last_index = line.find("[", last_index)
		
		if last_index == -1:
			_incorrect_format_error()
			return
		else:
			name_indices[i] = last_index
			last_index += 1
		
	for i in range(2, 4):
		last_index = line.find("]", last_index)
		
		if last_index == -1:
			_incorrect_format_error()
			return
		else:
			name_indices[i] = last_index
			last_index += 1
	
	character_A = line.substr(name_indices[0], name_indices[2])
	character_B = line.substr(name_indices[1], name_indices[3])

func _process_next_line(line):
	var dialogue_line: DialogueLine = DialogueLine.new()
	
	if line[0] == "[":
		var end_index = line.find("]")
		var temp: String = line.substr(0, end_index)
		
		if _validate_name(temp):
			dialogue_line.character_name = temp
	elif not script_array.empty():
		dialogue_line.character_name = script_array[-1].character_name
	else:
		_incorrect_format_error()
		return
	
	dialogue_line.text = line.get_slice("]", 1)
	script_array.append(dialogue_line)
	
func _validate_name(name: String):
	return name == character_A || name == character_B
	
func _incorrect_format_error():
	pass
