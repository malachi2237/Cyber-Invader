extends Node

class_name Dialogue

export(String, FILE, "*.txt") var script_file: String

var characters: Array = [] 

var script_array: Array

func consume_next_line() -> DialogueLine:
	return script_array.pop_front()
	
func _ready():
	_process_file(script_file)

func _process_file(file):
	var f = File.new()
	f.open(file, File.READ)
	
	var firstLine = true
	while not f.eof_reached():
		var line = f.get_line()
		if firstLine:
			_read_character_list(line)
			firstLine = false
		else:
			_process_next_line(line)

func _read_character_list(line):
	var opened_character_name = false
	var current_character_name: String = ""
	
	for c in line:
		
		if !opened_character_name and c == "[": opened_character_name = true
		
		elif opened_character_name and c == "]":
			characters.append(current_character_name)
			current_character_name = ""
			opened_character_name = false
		
		elif opened_character_name: current_character_name += c

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
	return characters.find(name) != -1
	
func _incorrect_format_error():
	pass
