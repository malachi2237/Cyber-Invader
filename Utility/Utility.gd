extends Node

class_name Utility

const hud_layer_path = "/root/GameScene/HudLayer"
const alt_hud_layer_path = "/root/MainMenu/HudLayer"
const play_area_path = "/root/GameScene/PlayLayer/PlayArea"
const player_path = "/root/GameScene/PlayLayer/Player"
const game_manager_path = "/root/GameScene/PlayLayer/GameManager"
const warnings = false

static func getScene(targetNode):
	var root = targetNode.get_tree().get_root()
	var scene = root.get_child(root.get_child_count()-1)
	return scene

static func is_game_scene(target_node) -> bool: 
	return target_node.get_node_or_null("/root/GameScene")

static func get_hud_layer(target_node) -> Control:
	var hud_layer =  target_node.get_node_or_null(hud_layer_path)
	if not hud_layer is CanvasLayer:
		hud_layer = target_node.get_node_or_null(alt_hud_layer_path)
		
	if not hud_layer is CanvasLayer:
		push_error("HUD Layer not found at expected path")
	return hud_layer
	
static func get_play_area(target_node) -> Control:
	var play_area =  target_node.get_node_or_null(play_area_path)
	if not play_area is Control:
		if(warnings): push_warning("Play area not found at expected path")
	return play_area
	
static func get_play_area_x_bounds(target_node, margin_percent: float) -> Vector2:
	var play_area : Control = get_play_area(target_node)
	
	if play_area:
		var pos = play_area.get_global_position()
		var size = play_area.get_size()
		var margin = size.x * margin_percent
		
		return Vector2(pos.x + margin, pos.x + size.x - margin)
	else:
		return Vector2(0, target_node.get_viewport().get_visible_rect().size.x)
		
static func get_play_area_y_bounds(target_node, margin_percent: float = 0.0) -> Vector2:
	var play_area : Control = get_play_area(target_node)
	
	if play_area:
		var pos = play_area.get_global_position()
		var size = play_area.get_size()
		var margin = size.y * margin_percent
		return Vector2(pos.y + margin, pos.y + size.y - margin)
	else:
		return Vector2(0, target_node.get_viewport().get_visible_rect().size.y)
		
#TODO: Refactor pattern for fewer arguments, while maintaining D.N.R
#D.N.R (DO NOT REPEAT)
static func setupTimer(target_node, _one_shot, _delay, _function) -> Timer:
	var newTimer = Timer.new()
	target_node.add_child(newTimer)
	newTimer.one_shot = _one_shot
	if _delay: newTimer.start(_delay)
	if _function: newTimer.connect("timeout", target_node, _function)
	return newTimer

static func placeInScene(target_node, item, _pos):
	getScene(target_node).add_child(item)
	if _pos != null: item.global_position = _pos

static func get_player(node_in_scene: Node):
	var player =  node_in_scene.get_node_or_null(player_path)
	if not player or not player.name == "Player":
		if(warnings): push_warning("Player not found at expected Path")
		return null
	return player

static func get_game_manager(node_in_scene: Node):
	var gm =  node_in_scene.get_node_or_null(game_manager_path)
	if not gm or not gm.name == "GameManager":
		if(warnings): push_warning("Game Manager not found at expected Path")
		return null
	return gm
