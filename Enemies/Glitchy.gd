extends Area2D

# Declare member variables here.
onready var warpTimer: Timer = $WarpTimer
onready var shadowClone: Sprite = $ShadowClone
onready var warpAnim: AnimationPlayer = $GlitchyAnimationPlayer
onready var screenSize:Vector2 = get_viewport().get_visible_rect().size
onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
onready var newSpot: Vector2 = self.position
onready var warping: bool = false
var animationList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	animationList = warpAnim.get_animation_list()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func warpIn() -> void:
	self.position = newSpot
	warpAnim.play("GlitchyFadeIn")

func chooseSpot() -> void:
	#choose random spot
	newSpot = Vector2(
		rng.randf_range(0, screenSize.x),
		rng.randf_range(0, screenSize.y))
	shadowClone.global_position = newSpot

func warpOut() -> void:
	warpAnim.play("GlitchyFadeOut")
	chooseSpot()

func makeShot() -> void:
	pass
	#shoot bullet pattern

func deathShot() -> void:
	pass
	#shoot death bullet pattern


func _on_WarpTimer_timeout() -> void:
	if not warping and not warpAnim.is_playing():
		warpOut()
	elif warping and not warpAnim.is_playing():
		warpIn()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if not warping:
		warping = true
	elif warping:
		makeShot()
		warping = false
	warpTimer.start()

