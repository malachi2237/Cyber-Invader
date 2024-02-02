extends Enemy

#TODO: Implement Boss Phase and its various modes
#Has the player as a target
var target = null

#Modes' signals
#warning can't find the trace here.
signal CirclePulse
signal Sweeping
signal HyperSnow


onready var modeTimer: Timer = $ModeTimer
onready var maxHealth = self.health

export var modeLength = [30, 30]
export var healthMilestones = [0.6, 0.3]
export var modes = ["CirclePulse", "Sweeping", "HyperSnow"]
var currentMode = 0

#Has three modes
#Mode 1: Pulses of circuling bullet
#Mode 2: Shifting Blocks and Sweeping Lazers
#Mode 3: Crazy Bullet snow, attop combinations of the previous patterns



#Signal to start modes?

func _ready():
	emit_Current_Mode()
	startModeTimer()

func _process(_delta) -> void:
	pass

func healthModeSwitchTest() -> void:
	if(nextModeValid() and healthMilestoneReached()):
		startNextMode()

func nextModeValid() -> bool:
	return currentMode+1 < (modes.size()-1)

func healthMilestoneReached() -> bool:
	return ((self.health/maxHealth) <= healthMilestones[currentMode])

func startNextMode() -> void:
	if(nextModeValid()):
		currentMode += 1
		emit_Current_Mode()
		startModeTimer()

func startModeTimer() -> void:
	modeTimer.wait_time = modeLength[currentMode]
	modeTimer.start()

func _on_ModeTimer_timeout():
	startNextMode()

func emit_Current_Mode():
	match modes[currentMode]:
		"CirclePulse": emit_signal("CirclePulse")
		"Sweeping": emit_signal("Sweeping")
		"HyperSnow": emit_signal("HyperSnow")
