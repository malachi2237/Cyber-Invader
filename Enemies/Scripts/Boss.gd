extends Enemy

#Has the player as a target
#Has three lazer guns
var target = null
onready var Guns = [$Bosscannon1, $Bosscannon2, $Bosscannon3]
onready var modeTimer: Timer = $ModeTimer
onready var maxHealth = self.health

export var modeCount:int = 3
export var modeLength = [30, 30]
export var healthMilestones = [0.6, 0.3]
export var modes = ["CirclePulse", "Sweeping", "HyperSnow"]
var currentMode = 0

#Has three modes
#Mode 1: Pulses of circuling bullet
#Mode 2: Shifting Blocks and Sweeping Lazers
#Mode 3: Crazy Bullet snow, attop combinations of the previous patterns

# Called when the node enters the scene tree for the first time.
func _ready():
	startModeTimer()

func _process(_delta) -> void:
	pass

func nextModeValid() -> bool:
	return currentMode < modeCount -1

func healthMilestoneReached() -> bool:
	return (self.health/maxHealth) <= healthMilestones[currentMode] 

#Can move between modes via Health milestones
func healthModeSwitchTest() -> void:
	if(nextModeValid() and healthMilestoneReached()): startNextMode()

func startNextMode() -> void:
	if(nextModeValid()): 
		currentMode += 1
		startModeTimer()

func startModeTimer() -> void:
	modeTimer.one_shot = true
	modeTimer.wait_time = modeLength[currentMode]
	modeTimer.start()

#Has a timer that moves between Modes
func _on_ModeTimer_timeout():
	startNextMode()
