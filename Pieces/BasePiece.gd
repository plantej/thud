extends Area2D


export var dwarf = false
export var troll = false

onready var moves = $Moves
onready var ray = $RayCast2D


func clearMoves():
	if moves.get_child_count() > 0:
		for node in moves.get_children():
			node.queue_free()

func spawnMoves():
	pass
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "piece", "clearMoves")
	for dir in Common.dirs:
		spawnMove(dir)
		spawnSpecialMove(dir)

func spawnMove(dir):
	pass

func spawnSpecialMove(dir):
	pass

func isDwarf():
	return dwarf

func isTroll():
	return troll

func _on_TextureButton_pressed():
	spawnMoves()
