extends TextureButton

var capture
var spawner



func setHomePiece(node):
	spawner = node

func setCapturePiece(node):
	capture = node

func clear():
	queue_free()

func _pressed():
	executeMove()
	

func executeMove():
	capture.queue_free()
	spawner.clearMoves()
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "troll")

