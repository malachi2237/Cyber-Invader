extends Node2D

export var directions: Array = [Vector2.RIGHT, Vector2.LEFT] 
export var speed: float = 5
var cur_dir = 0
onready var wiggleSwitchTimer: Timer = $wiggleSwitch
export var direction_time: float = 3
func _ready():
	wiggleSwitchTimer.wait_time = direction_time
	wiggleSwitchTimer.start()
	wiggleSwitchTimer.one_shot = false

func _process(delta):
	wiggle(delta, cur_dir)

func wiggle(delta, switched):
	translate(delta*speed*directions[cur_dir])

func next_dir():
	cur_dir += 1
	cur_dir = cur_dir % directions.size()

func _on_wiggleSwitch_timeout():
	next_dir()
