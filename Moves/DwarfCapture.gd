extends "res://Moves/BaseMove.gd"

var capture

func setCapturePiece(node):
	capture = node

func executeMove():
	capture.queue_free()
	spawner.set_global_position(self.get_global_position() + Common.offset)
	spawner.clearMoves()
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "dwarf")
	
func _on_Sprite_pressed():
	executeMove()
