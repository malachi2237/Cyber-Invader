extends Node

class_name Utility

#------------------------------------------------
static func getScene(targetNode):
	var root = targetNode.get_tree().get_root()
	var scene = root.get_child(root.get_child_count()-1)
	return scene

static func setupTimer(targetNode, _one_shot, _delay, _function) -> Timer:
	var newTimer = Timer.new()
	targetNode.add_child(newTimer)
	newTimer.one_shot = _one_shot
	if _delay: newTimer.start(_delay) 
	if _function: newTimer.connect("timeout", targetNode, _function)
	return newTimer
#-------------------------------------------------