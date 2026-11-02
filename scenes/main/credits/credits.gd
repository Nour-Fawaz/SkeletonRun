extends Control
class_name Credits

var games : Array[PackedScene]
var spinny_text : Array[Label]

@onready var games_container := $Margin/ScrollContainer/Games
@onready var game_template := $Margin/ScrollContainer/Games/Game

func set_games(g : Array[PackedScene], play_callback: Callable) -> void:
	games = g
	generate_credits(play_callback)

func generate_credits(play_callback: Callable) -> void:
	game_template.visible = false
	var first = null
	var second = null
	var third = null
	for i in range(games.size()):
		var game := games[i].instantiate() as Microgame
		var card := game_template.duplicate()
		card.visible = true
		games_container.add_child(card)
		card.get_node("Margin/Info/Text/Title").text = game.game_name
		card.get_node("Margin/Info/Text/Person").text = "by %s" % game.creator_name
		card.get_node("Margin/Info/Text/Description").text = game.game_description
		
		# Replace with new winners
		if game.game_name == "First Place":
			first = card
			spinny_text.append(card.get_node("1st"))
		if game.game_name == "Second Place":
			second = card
			spinny_text.append(card.get_node("2nd"))
		if game.game_name == "Third Place":
			third = card
			spinny_text.append(card.get_node("3rd"))
		
		var vp := card.get_node("Margin/Info/Preview/SubViewport") as SubViewport
		vp.add_child(game)
		await RenderingServer.frame_post_draw
		game.queue_free()
		card.get_node("Margin/Info/Preview/Panel/Image").texture = vp.get_texture()
		
		card.get_node("Margin/Info/Preview/Button").pressed.connect(play_callback.bind(games[i]))

	if first:
		games_container.move_child(first, 0)
	if second:
		games_container.move_child(second, 1)
	if third:
		games_container.move_child(third, 2)

var counter := 0.0
func _process(delta: float) -> void:
	counter += delta * 5
	for label in spinny_text:
		label.visible = true
		label.pivot_offset = label.size / 2
		label.rotation_degrees = remap(sin(counter), -1, 1, -5, 5)
