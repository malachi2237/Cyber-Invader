extends Enemy

onready var big_attack = $BigSlow
onready var small_attack = $SmallFast


export(float) var entry_speed = 25.0
export(float) var entry_direction = 0.0
export(float) var entry_travel_distance = 0.0

export(float) var small_attack_delay = 4.0

var distance_traveled = 0.0

func _process(delta):
	if (distance_traveled < entry_travel_distance):
		_dramaticEntrance(delta)

func _dramaticEntrance(delta: float) -> void:
	var direction = Vector2.DOWN.rotated(entry_direction).normalized()
	var distance = entry_speed * delta
	_recordedMovement(direction, distance)
	_concludeEntranceCondition()

func _recordedMovement(direction: Vector2, distance: float) -> void:
	self.translate(direction * distance)
	distance_traveled += distance

func _concludeEntranceCondition() -> void:
	if (distance_traveled >= entry_travel_distance):
		_begin_attacking()

func _begin_attacking() -> void:
	var _smallAttackTimer = Utility.setupTimer(
			small_attack, true, small_attack_delay, "start_firing")
	big_attack.start_firing()
