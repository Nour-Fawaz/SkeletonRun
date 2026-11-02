extends CharacterBody2D


@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var skeleton_animated_sprite = $AnimatedSprite2D

@onready var player = get_tree().get_first_node_in_group("FollowPlayerAI") # reference of player
#@onready var player: CharacterBody2D = $PC_Body

func _physics_process(delta: float) -> void:
	if position > player.global_position:
		skeleton_animated_sprite.flip_h = true
	else:
		skeleton_animated_sprite.flip_h = false
	var direction = position.direction_to(player.global_position).normalized()
	velocity = direction * SPEED
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
