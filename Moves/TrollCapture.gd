extends "res://Moves/BaseMove.gd"

var capture

func setCapturePiece(node):
	capture = node

func executeMove():
	capture.queue_free()
	spawner.clearMoves()
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "troll")

func _on_Sprite_pressed():
	executeMove()
	#get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "move", "clear")
