extends Enemy

onready var homePos: Vector2 = self.position

var attackTarget: Node2D = null

export var attackPos: Vector2 = Vector2(0,0)
export var speed: float = 10

onready var aimTimer: Timer = $AimTimer
onready var chargeLag: Timer = $ChargeLag
onready var bulletSpawner: BulletSpawner = $BrickSpawner

var hasPlayer: bool = false
var moveDir:Vector2 = Vector2(0,0)

enum Mood{ attack, regroup }

enum Sequence { aim, charge, repeat }

var curMood = Mood.attack
var curSeq = Sequence.aim

#----------------------------------------------
func set_attack_target(targetNode: Node2D) -> void:
	if targetNode: attackTarget = targetNode
#----------------------------------------------

#----------------------------------------------
func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	match curMood:
		Mood.attack: attack(delta)
		Mood.regroup: regroup(delta)
#----------------------------------------------

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
	# TODO: would prefer the aim to be a spin to point, look_at() is instant
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
