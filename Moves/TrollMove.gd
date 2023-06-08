extends "res://Moves/BaseMove.gd"




func executeMove():
	spawner.set_global_position(self.get_global_position() + Common.offset)
	spawner.clearMoves()
	spawner.buildCaptures()
	#buildCaptures()



func _on_Sprite_pressed():
	executeMove()
	#get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "move", "clear")
