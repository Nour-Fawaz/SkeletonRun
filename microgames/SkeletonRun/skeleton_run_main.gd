extends Microgame
@onready var player = $PC_Body
@onready var enemy = $Skeleton_Body
@onready var game_music = $GameAudio
var losses = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	# signal functions
	enemy.player_enemy_collision.connect(_on_skeleton_body_player_enemy_collision)
	# player wins if they don't get bumped into
	lose_on_timeout = false
	# start playing game audio
	game_music.play()
	
	
func _on_skeleton_body_player_enemy_collision() -> void:
	post_game_time = 0.4
	losses += 1
	lose_game.emit()

	
