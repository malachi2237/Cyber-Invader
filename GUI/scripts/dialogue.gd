extends Node

class_name Dialogue

export(String, FILE, "*.txt") var script_file: String

var character_a: String = ""
var character_b: String = ""

var script_array: Array

func consume_next_line() -> DialogueLine:
	return script_array.pop_front()
	
func _ready():
	_process_file(script_file)

func _process_file(file):
	var f = File.new()
	f.open(file, File.READ)
	
	if not f.eof_reached():
		var first_line = f.get_line()
		_read_character_list(first_line)
		
	while not f.eof_reached():
		var line = f.get_line()
		_process_next_line(line)

func _read_character_list(line):
	var name_indices: PoolIntArray = PoolIntArray()
	var last_index = 0
	
	name_indices.resize(4)
	
	for i in range(2):
		last_index = line.find("[", last_index)
		
		if last_index == -1:
			_incorrect_format_error()
			return
		else:
			last_index += 1
			name_indices[i] = last_index
	
	last_index = 0
	for i in range(2, 4):
		last_index = line.find("]", last_index)
		
		if last_index == -1:
			_incorrect_format_error()
			return
		else:
			name_indices[i] = last_index
			last_index += 1
	
	character_a = line.substr(name_indices[0], name_indices[2] - name_indices[0])
	character_b = line.substr(name_indices[1], name_indices[3] - name_indices[1])

func _process_next_line(line):
	var dialogue_line: DialogueLine = DialogueLine.new()
	
	if line[0] == "[":
		var end_index = line.find("]")
		var temp: String = line.substr(1, end_index - 1)
		
		if _validate_name(temp):
			dialogue_line.character_name = temp
	elif not script_array.empty():
		dialogue_line.character_name = script_array[-1].character_name
	else:
		_incorrect_format_error()
		return
	
	dialogue_line.text = line.get_slice("]", 1)
	script_array.append(dialogue_line)
	
func _validate_name(name: String) -> bool:
	return name == character_a || name == character_b
	
func _incorrect_format_error():
	pass
