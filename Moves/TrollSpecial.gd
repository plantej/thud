extends "res://Moves/TrollMove.gd"

onready var ray = $Ray
onready var capture = $Captures
onready var redXSprite = preload("res://Moves/RedXSprite.tscn")
var captures = []


func parseCaptures():
	for dir in Common.dirs:
		print(str(dir * Common.tileSize))
		Common.point(ray, dir * Common.tileSize)
		if ray.is_colliding():
			captures.append(ray.get_collider())

func addSprite():
	for node in captures:
		var sprite = redXSprite.instance()
		capture.add_child(sprite)
		sprite.set_global_position(node.get_global_position())	

func validate():
	parseCaptures()
	if len(captures) == 0:
		queue_free()
	else:
		addSprite()

func executeMove():
	spawner.set_global_position(self.get_global_position() + Common.offset)
	processCaptureRemovals()
	spawner.clearMoves()
	get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "troll")
	
func processCaptureRemovals():
	for node in captures:
		node.queue_free()
