extends Enemy

onready var homePos: Vector2 = self.position

var attackTarget: Node2D = null

export var attackPos: Vector2 = Vector2(0,0)
export var speed: float = 10

onready var aimTimer: Timer = $AimTimer
onready var chargeLag: Timer = $ChargeLag
onready var bulletSpawner: BulletSpawner = $BulletSpawner

var hasPlayer: bool = false
var moveDir:Vector2 = Vector2(0,0)

#TODO: Reconsider Mood/Sequence dynamic to require less functional maintenence
enum Mood{ attack, regroup }

enum Sequence { aim, charge, repeat }

var curMood = Mood.attack
var curSeq = Sequence.aim

func set_attack_target(targetNode: Node2D) -> void:
	if targetNode: attackTarget = targetNode
		
func _ready() -> void:
	set_attack_target(Utility.get_player(self))
	
func _physics_process(delta: float) -> void:
	match curMood:
		Mood.attack:
			_attack(delta)
		Mood.regroup:
			_regroup(delta)

func _attack(delta) -> void:
	if (curSeq == Sequence.aim and attackTarget):
		attackPos = attackTarget.position
		
	_sequence(Mood.regroup, attackPos, delta)

func _regroup(delta) -> void:
	_sequence(Mood.attack, homePos, delta)

func _sequence(nextMood, targetPos, delta) -> void:
	match curSeq:
		Sequence.aim:
			_aim(targetPos, delta)
		Sequence.charge:
			_charge(targetPos, delta)
		Sequence.repeat:
			_repeatSequence(nextMood)

func _aim(targetPos, _delta) -> void:
	if aimTimer.is_stopped(): aimTimer.start()
	# TODO: would prefer the aim to be a spin to point, look_at() is instant
	look_at(targetPos)
	moveDir = position.direction_to(targetPos)

func _charge(targetPos, delta) -> void:
	translate(speed*moveDir*delta)
	if (position.distance_to(targetPos) < 1):
		chargeLag.start()

func _repeatSequence(nextMood) -> void:
	curMood = nextMood
	curSeq = Sequence.aim
	bulletSpawner.stop_firing()

func _on_AimTimer_timeout() -> void:
	curSeq = Sequence.charge
	bulletSpawner.start_firing()

func _on_ChargeLag_timeout():
	curSeq = Sequence.repeat
