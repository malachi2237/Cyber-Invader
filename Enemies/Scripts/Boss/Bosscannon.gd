extends AnimatedSprite

var active = false
export var aim_speed = 2
export var firing_turn_speed = 1
export var aim_range = 30
var current_action = 'aim'
var aim_dir = 1
onready var bullets : BulletSpawner = $BulletSpawner
var is_firing = false

func _process(delta: float) -> void:
	if(active):
		perform_action(delta)

func fire(_delta: float):
	self.animation = 'Firing'
	if(!is_firing):
		is_firing = true
		bullets.start_firing()

func charge(_delta: float):
	self.animation = 'Charging'

func flip_aim_cond():
	return (self.rotation_degrees >= aim_range or
		self.rotation_degrees <= -aim_range)


func aim(delta: float):
	if(is_firing):
		is_firing = false
		bullets.stop_firing()
	self.animation = 'Idle'
	if(Utility.get_player(self)):
		self.look_at(Utility.get_player(self).position)
		self.rotation_degrees -= 90
	else:
		self.rotate(aim_dir*aim_speed*delta)
	if(flip_aim_cond()):
		aim_dir = -aim_dir

func perform_action(delta: float):
	match current_action:
		'aim': aim(delta)
		'charge': charge(delta)
		'fire': fire(delta)

func set_action(actionName: String):
	current_action = actionName

