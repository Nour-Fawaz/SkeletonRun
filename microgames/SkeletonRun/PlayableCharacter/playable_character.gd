extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0
var normal_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_amplifier = 5.0

@onready var pc_animated_sprite = $AnimatedSprite2D
@onready var enemy = $"../Skeleton_Body"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		var current_gravity = normal_gravity
		if velocity.y > 0: # speed up descent
			current_gravity = normal_gravity * gravity_amplifier
		velocity.y += current_gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		pc_animated_sprite.play("jump") # jumping -> play idle

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right") # 1. Get input direction (-1 for left, 1 for right, 0 for none)
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			pc_animated_sprite.flip_h = false # right
		elif direction < 0:
			pc_animated_sprite.flip_h = true # left
		pc_animated_sprite.play("walk")# play walk animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) # idle
		pc_animated_sprite.play("idle") # play idle animation

	move_and_slide() # move character using built in physics
		
