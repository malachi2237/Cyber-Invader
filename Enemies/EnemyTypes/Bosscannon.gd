extends AnimatedSprite

var action_order = ['aim', 'charge', 'fire']
export var action_times = [10, 10, 10]
var cur_action = 0


func _process(delta: float) -> void:
	perform_action(delta)

func fire(delta: float):
	pass

func charge(delta: float):
	pass

func aim(delta: float):
	self.rotate(2*delta)


func perform_action(delta: float):
	match action_order[cur_action]:
		'aim': aim(delta)
		'charge': charge(delta)
		'fire': fire(delta)

