extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var shotSpeed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _physics_process(delta: float) -> void:
	position.y -= shotSpeed*delta

func _on_EndBullet_timeout() -> void:
	self.queue_free()
