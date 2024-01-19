extends Node2D

onready var Guns = [$Bosscannon1, $Bosscannon2, $Bosscannon3]
export var action_times = [10, 10, 10]
var action_order = ['aim', 'charge', 'fire']
var cur_action = 0


onready var actionTimer: Timer =  $ActionTimer

func _ready() -> void:
	start_action_timer()

func _on_Boss_Sweeping() -> void:
	for gun in Guns:
		gun.active = 1


func start_action_timer():
	actionTimer.wait_time = action_times[cur_action]
	actionTimer.one_shot = true
	actionTimer.start()

func _on_ActionTimer_timeout() -> void:
	cur_action += 1
	cur_action = cur_action % action_order.size()
	start_action_timer()
	for gun in Guns:
		print_debug(action_order[cur_action])
		gun.set_action(action_order[cur_action])

