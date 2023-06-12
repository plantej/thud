extends TextureButton

var spawner

func setHomePiece(node):
	spawner = node

func clear():
	queue_free()


func _pressed():
	executeMove()


func executeMove():
	spawner.set_global_position(self.get_global_position() + Common.offset)
	spawner.clearMoves()
	spawner.buildCaptures()
	#buildCaptures()
