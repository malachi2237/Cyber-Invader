extends Timer

export(float) var start_delay_min = 0.0
export(float) var start_delay_max = 0.0

func _ready():
	if(_delayCondition()):
		_randomDelay()

func _delayCondition() -> bool:
	return (start_delay_min >= 0.0
			and
			start_delay_min <= start_delay_max)

func _randomDelay() -> void:
	self.wait_time = rand_range(start_delay_min, start_delay_max)
