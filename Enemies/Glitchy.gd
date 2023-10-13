extends Area2D

# Declare member variables here.
onready var warpTimer: Timer = $WarpTimer
onready var screenSize:Vector2 = get_viewport().get_visible_rect().size
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
onready var newSpot: Vector2 = self.position
onready var warping: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func warpIn() -> void:
	self.position = newSpot
	self.visible = true
	makeShot()

func chooseSpot() -> void:
	#choose random spot
	newSpot = Vector2(
		rng.randf_range(0, screenSize.x),
		rng.randf_range(0, screenSize.y))

func warpOut() -> void:
	self.visible = false
	chooseSpot()

func makeShot() -> void:
	pass
	#shoot bullet pattern

func deathShot() -> void:
	pass
	#shoot death bullet pattern


func _on_WarpTimer_timeout() -> void:
	if not warping:
		warpOut()
		warping = true
	elif warping:
		warping = false
		warpIn()
	warpTimer.start()
