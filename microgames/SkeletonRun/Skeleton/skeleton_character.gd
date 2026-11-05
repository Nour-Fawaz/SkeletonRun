extends CharacterBody2D

@export var SPEED = 300.0
@export var gravity_amplifier = 10.0
const JUMP_VELOCITY = -400.0
var normal_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var skeleton_animated_sprite = $Skeleton_AnimatedSprite
@onready var player = get_tree().get_first_node_in_group("FollowPlayerAI") # reference of player

signal player_enemy_collision() # signal on enemy collision

func _physics_process(delta: float) -> void:
	
	# flip sprite depending on player direction
	if position > player.global_position: 
		skeleton_animated_sprite.flip_h = true
	else:
		skeleton_animated_sprite.flip_h = false
	var direction = position.direction_to(player.global_position).normalized()
	velocity = direction * SPEED
	
	# increase grvaity 
	var current_gravity = normal_gravity
	if velocity.y > 0: # speed up descent
		current_gravity = normal_gravity * gravity_amplifier
	velocity.y += current_gravity * delta
	move_and_slide()
	
	
func _on_enemy_area_body_entered(body: Node2D) -> void:
	skeleton_animated_sprite.play("jumpscare") # set jumpscare animation
	player_enemy_collision.emit() # emit signal that there was a player and enemy collision
	
