extends Enemy

# Declare member variables here.
onready var warpTimer: Timer = $WarpTimer
onready var shadowClone: Sprite = $ShadowClone
onready var spriteAnim : AnimatedSprite = $GlitchySprite
onready var warpAnim: AnimationPlayer = $GlitchyAnimationPlayer
onready var bulletSpawner: BulletSpawner = $BulletSpawner

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

func warpIn() -> void:
	self.position = newSpot
	warpAnim.play("GlitchyFadeIn")
	shadowClone.visible = false

func chooseSpot() -> void:
	#choose random spot
	newSpot = Vector2(
		rng.randf_range(0, screenSize.x),
		rng.randf_range(0, screenSize.y))
	shadowClone.visible = true
	shadowClone.global_position = newSpot

func warpOut() -> void:
	warpAnim.play("GlitchyFadeOut")

func deathShot() -> void:
	pass
	#shoot death bullet pattern

func _on_WarpTimer_timeout() -> void:
	if not warping:
		warpOut()
		bulletSpawner.stop_firing()
		spriteAnim.play("default")
	elif warping:
		warpIn()

func _on_GlitchyAnimationPlayer_animation_finished(_anim_name):
	if not warping:
		chooseSpot()
		warping = true
	elif warping:
		bulletSpawner.start_firing()
		spriteAnim.play("shoot")
		warping = false
	warpTimer.start()
