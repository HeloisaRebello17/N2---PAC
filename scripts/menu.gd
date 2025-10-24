extends Node

var pieceScene = load("res://scenes/piece.tscn")
var pieceInstance : Object
var labelText : String

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load highscore from file and display it on existing menu label
	var highscore_label := get_node_or_null("CenterContainer2/Label")
	if highscore_label:
		var hs := "0"
		if not FileAccess.file_exists("user://score.save"):
			FileAccess.open("user://score.save", FileAccess.WRITE).store_string("0")
		else:
			hs = FileAccess.open("user://score.save", FileAccess.READ).get_as_text()
		highscore_label.text = "HIGHSCORE\n" + hs
	
# Spawn random piece
func handle_piece():
	# Menu scene no longer has the preview nodes; skip spawning demo piece
	pass

# Play game
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Quit game
func _on_quit_pressed():
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "spin":
		$"Piece container/PIECE/AnimationPlayer".play("spin2")
		handle_piece()
	elif anim_name == "spin2":
		$"Piece container/PIECE/AnimationPlayer".play("spin")
		#handle_piece()
