extends Microgame
@onready var player = $PC_Body
@onready var enemy = $Skeleton_Body

var losses = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	enemy.player_enemy_collision.connect(_on_skeleton_body_player_enemy_collision)
	lose_on_timeout = losses > 2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_skeleton_body_player_enemy_collision() -> void:
	print("Enemy bumped into payer!!!")
	post_game_time = 0.4
	losses += 1
	lose_game.emit()
	pass # Replace with function body.
