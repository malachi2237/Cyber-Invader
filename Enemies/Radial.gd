extends Enemy

onready var big_attack = $BigSlow
onready var small_fast = $SmallFast

func _ready():
	pass
	big_attack.connect("stopped_firing", small_fast, "start_firing")
	small_fast.connect("stopped_firing", big_attack, "start_firing")
