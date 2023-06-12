extends TextureButton

var capture
var spawner



func setHomePiece(node):
	spawner = node

func clear():
	queue_free()


func _pressed():
	executeMove()

func setCapturePiece(node):
	capture = node

func executeMove():
	capture.queue_free()
	spawner.set_global_position(self.get_global_position() + Common.offset)
	spawner.clearMoves()
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "dwarf")
