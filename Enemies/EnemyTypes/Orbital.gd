extends Node2D

export var radialSpeed = 1
var radian = 0.0


func _physics_process(delta):
	get_child(0).position += Vector2(sin(radian), cos(radian))
	radian += radialSpeed*delta
	if(radian > 2*PI): radian = 0
