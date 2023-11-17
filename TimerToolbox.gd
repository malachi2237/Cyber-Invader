extends Node

class_name TimerToolbox

onready var targetTimer: Timer = Timer.new()

func getTimer()->Timer:
	return targetTimer

func addTimerChild(targetNode):
	targetNode.add_child(targetTimer)

func _timeoutSignalConnectionError():
	print_debug(self.name +
			" failed to connect timeout signal")

func connectTimeoutSignal(targetNode, functionName):
	if(targetTimer.connect("timeout", targetNode, functionName)): return
	else: _timeoutSignalConnectionError()

func setupTimer(one_shot, _waitTime, _autoStart):
	targetTimer.one_shot = one_shot
	if _waitTime: targetTimer.start(_waitTime)
	targetTimer.autostart = _autoStart
