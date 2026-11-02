extends Microgame
@onready var player = $PC_Body
@onready var enemy = $Skeleton_Body
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	enemy.player_enemy_collision.connect(_on_skeleton_body_player_enemy_collision)
	
	
	 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Time Left: ", $BombTimer.tick_count)
	pass
	



func _on_skeleton_body_player_enemy_collision() -> void:
	print("Enemy bumped into payer!!!")
	pass # Replace with function body.
