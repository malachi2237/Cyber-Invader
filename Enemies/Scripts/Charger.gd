extends Enemy

# TODO!
# would prefer the aim to be a spin to point, look_at() is instant

# Declare member variables here.
onready var homePos: Vector2 = self.position
var attackTarget: Node2D
export var attackPos: Vector2 = Vector2(0,0)
export var speed: float = 10
onready var aimTimer: Timer = $AimTimer
onready var chargeLag: Timer = $ChargeLag
onready var bulletSpawner: BulletSpawner = $BrickSpawner
var hasPlayer: bool = false
var moveDir:Vector2 = Vector2(0,0)

enum Mood{
	attack,
	regroup
}

enum Sequence {
	aim,
	charge,
	repeat
}

var curMood = Mood.attack
var curSeq = Sequence.aim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# need a better object management to
	# capture the player position for the charger
	#player = get_node("/root/GameScene/Player")
	#if player:
	#	hasPlayer = true
	pass # Replace with function body.

func set_attack_target(targetNode: Node2D) -> void:
	if targetNode:
		attackTarget = targetNode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match curMood:
		Mood.attack: attack(delta)
		Mood.regroup: regroup(delta)

#----------------------------------------------
func attack(delta) -> void:
	if (curSeq == Sequence.aim and attackTarget): 
		attackPos = attackTarget.position
	sequence(Mood.regroup, attackPos, delta)

func regroup(delta) -> void: sequence(Mood.attack, homePos, delta)
#----------------------------------------------

#----------------------------------------------
func sequence(nextMood, targetPos, delta) -> void:
	match curSeq:
		Sequence.aim: aim(targetPos, delta)
		Sequence.charge: charge(targetPos, delta)
		Sequence.repeat: repeatSequence(nextMood)
#----------------------------------------------

#----------------------------------------------
func aim(targetPos, _delta) -> void:
	if aimTimer.is_stopped(): aimTimer.start()
	look_at(targetPos)
	moveDir = position.direction_to(targetPos)

func charge(targetPos, delta) -> void:
	translate(speed*moveDir*delta)
	if (position.distance_to(targetPos) < 1): chargeLag.start()

func repeatSequence(nextMood) -> void:
	curMood = nextMood
	curSeq = Sequence.aim
	bulletSpawner.stop_firing()
#----------------------------------------------

#----------------------------------------------
func _on_AimTimer_timeout() -> void:
	curSeq = Sequence.charge
	bulletSpawner.start_firing()

func _on_ChargeLag_timeout():
	curSeq = Sequence.repeat
#----------------------------------------------
