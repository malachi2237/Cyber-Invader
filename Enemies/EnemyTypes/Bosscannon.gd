extends AnimatedSprite

var action_order = ['aim', 'charge', 'fire']
export var action_times = [10, 10, 10]
var cur_action = 0


func _process(delta: float) -> void:
	perform_action()

func fire():
	pass

func charge():
	pass

func aim():
	self.rotate(2)


func perform_action():
	match action_order[cur_action]:
		'aim': aim()
		'charge': charge()
		'fire': fire()

