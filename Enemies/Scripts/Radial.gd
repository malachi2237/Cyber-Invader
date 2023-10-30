extends Enemy

onready var big_attack = $BigSlow
onready var small_fast = $SmallFast


export(float) var entry_speed = 25.0
export(float) var entry_direction = 0.0
export(float) var entry_travel_distance = 0.0

export(float) var small_attack_delay = 4.0

var distance_traveled = 0.0

func _process(delta):
	if (distance_traveled < entry_travel_distance):
		var direction = Vector2.DOWN.rotated(entry_direction)
		var travel_dist = entry_speed * delta
		
		direction = direction.normalized()
		translate(direction * travel_dist)
		
		distance_traveled += travel_dist
		
		if (distance_traveled >= entry_travel_distance):
			_begin_attacking()


func _begin_attacking():
	var small_delay_timer = Timer.new()
	
	big_attack.start_firing()
	
	add_child(small_delay_timer)
	small_delay_timer.one_shot = true
	small_delay_timer.connect("timeout", small_fast, "start_firing")
	small_delay_timer.start(small_attack_delay)
