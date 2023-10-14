extends Enemy

# TODO!
# issue with resetting the sequence
# needs the player position to be the attack position
# would prefer the aim to be a spin to point, look_at() is instant

# Declare member variables here.
export var homePos: Vector2 = self.position
#export var attackTarget: Player = preload("res://Player/Player.tscn")
export var attackPos: Vector2 = Vector2(0,0)
export var speed: float = 10

onready var aimTimer: Timer = $AimTimer
onready var shotTimer: Timer = $ShotTimer
onready var chargeLag: Timer = $chargeLag
onready var bulletSpawner: BulletSpawner = $BulletSpawner

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match curMood:
		Mood.attack:
			attack(delta)
		Mood.regroup:
			regroup(delta)

func attack(delta) -> void:
	sequence(Mood.regroup, attackPos, delta)

func regroup(delta) -> void:
	sequence(Mood.attack, homePos, delta)

func sequence(nextMood, targetPos, delta) -> void:
	match curSeq:
		Sequence.aim:
			aim(targetPos, delta)
		Sequence.charge:
			charge(targetPos, delta)
		Sequence.repeat:
			curMood = nextMood
			curSeq = Sequence.aim

func aim(targetPos, _delta) -> void:
	bulletSpawner.shotsEnabled = false
	if aimTimer.is_stopped():
		aimTimer.start()
	look_at(targetPos)
	moveDir = position.direction_to(targetPos)

func charge(targetPos, delta) -> void:
	# periodically shoot while charging
	bulletSpawner.shotsEnabled = true
	translate(speed*moveDir*delta)
	if position.distance_to(targetPos) < 0.5:
		print(targetPos)
		chargeLag.start()
	# charge goes to target position, with a follow through



#func shoot() -> void:
#	pass
#	print("BANG!")
	# periodically shoot a bullet
	# from each left/right side


func _on_AimTimer_timeout() -> void:
	curSeq = Sequence.charge


#func _on_ShotTimer_timeout() -> void:
#	shoot()

func _on_chargeLag_timeout() -> void:
	print("reset")
	curSeq = Sequence.repeat
