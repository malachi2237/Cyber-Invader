extends Enemy

onready var big_attack = $BigSlow
onready var small_fast = $SmallFast

export(float) var bullet_wave_interval = 1.0

var bullet_wave_timer
