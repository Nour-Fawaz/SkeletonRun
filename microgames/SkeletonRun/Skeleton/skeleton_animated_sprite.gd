extends AnimatedSprite2D

@export var target_scale: Vector2 = Vector2(0.6, 0.6) # how big it should get
@export var growth_duration: float = 0.5 # how fast it should grow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_changed.connect(_on_animation_changed)
	
func _on_animation_changed() -> void:
		
	if animation == "jumpscare":
		scale = Vector2(0.02, 0.02) # set scale smaller than walk animation
		offset = Vector2(-200, 0) # move tetxure so that its centered
		
		var tween = create_tween() # create tween
		tween.tween_property(self, "scale", target_scale, growth_duration) # make it grow to target
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT) # to burst out into player face aggresively
	else:
		offset = Vector2.ZERO # reset offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
