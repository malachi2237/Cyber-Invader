extends AnimatedSprite

var action_order = ['aim', 'charge', 'fire']
export var action_times = [10, 10, 10]
var cur_action = 0


func fire():
	pass

func charge():
	pass

func aim():
	pass


func switch_action():
	match action_order[cur_action]:
		'aim': aim()
		'charge': charge()
		'fire': fire()

