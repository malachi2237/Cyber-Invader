extends Node

class_name Utility

const play_area_path = "/root/GameScene/PlayLayer/PlayArea"
const player_path = "/root/GameScene/PlayLayer/PlayArea/Player"

static func getScene(targetNode):
	var root = targetNode.get_tree().get_root()
	var scene = root.get_child(root.get_child_count()-1)
	return scene

static func is_game_scene(targetNode) -> bool: 
	return targetNode.get_node_or_null("/root/GameScene")

static func get_play_area(targetNode) -> Control:
	var play_area =  targetNode.get_node_or_null(play_area_path)
	if not play_area is Control:
		push_error("Play area not found at expected path")
	return play_area

static func get_play_area_x_bounds(targetNode, margin_percent: float) -> Vector2:
	var play_area : Control = get_play_area(targetNode)
	
	if play_area:
		var pos = play_area.get_global_position()
		var size = play_area.get_size()
		var margin = size.x * margin_percent
		
		return Vector2(pos.x + margin, pos.x + size.x - margin)
	else:
		return Vector2(0, targetNode.get_viewport().get_visible_rect().size.x)
		
static func get_play_area_y_bounds(targetNode, margin_percent: float = 0.0) -> Vector2:
	var play_area : Control = get_play_area(targetNode)
	
	if play_area:
		var pos = play_area.get_global_position()
		var size = play_area.get_size()
		var margin = size.y * margin_percent
		return Vector2(pos.y + margin, pos.y + size.y - margin)
	else:
		return Vector2(0, targetNode.get_viewport().get_visible_rect().size.y)
		
#TODO: Refactor pattern for fewer arguments, while maintaining D.N.R
#D.N.R (DO NOT REPEAT)
static func setupTimer(targetNode, _one_shot, _delay, _function) -> Timer:
	var newTimer = Timer.new()
	targetNode.add_child(newTimer)
	newTimer.one_shot = _one_shot
	if _delay: newTimer.start(_delay)
	if _function: newTimer.connect("timeout", targetNode, _function)
	return newTimer

static func placeInScene(targetNode, item, _pos):
	getScene(targetNode).add_child(item)
	if _pos != null: item.global_position = _pos

static func get_player(node_in_scene: Node):
	var scene = getScene(node_in_scene)
	var player = scene.find_node("Player")
	
	return player
