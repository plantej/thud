extends "res://Pieces/BasePiece.gd"

onready var normalMove = preload("res://Moves/BaseMove.tscn")
onready var specialMove = preload("res://Moves/DwarfCapture.tscn")
onready var button = get_node("CenterContainer/TextureButton")
#onready var normalMove = preload("res://Moves/BaseMove.tscn")

func activate():
#	button.set_disabled(false)
	button.set_button_mask(BUTTON_MASK_LEFT)

func deactivate():
	button.set_button_mask(BUTTON_MASK_RIGHT)
#	button.set_disabled(true)

func spawnMove(dir):
	var stop = false
	var step = 1
	var globPos = self.get_global_position()
	while not stop:
		var delta = dir * Common.tileSize * step
		Common.point(ray, delta)
		if ray.is_colliding():
			stop = true
		else:
			createMove(globPos + delta)
			step += 1


func createMove(newPos):
	var moveInstance = normalMove.instance()
	moves.add_child(moveInstance)
	moveInstance.set_global_position(newPos - Common.offset)
	moveInstance.setHomePiece(self)



func spawnSpecialMove(dir):
	var stepsToTroll = trollDistance(dir)
	if stepsToTroll > 0:
		var dwarfLine = dwarfLine(-1 * dir)
		if dwarfLine >= stepsToTroll:
			createSpecialMove(dir, stepsToTroll)


func createSpecialMove(dir, steps):
	var captureMove = specialMove.instance()
	moves.add_child(captureMove)
	captureMove.setHomePiece(self)
	var delta = dir * Common.tileSize * steps
	Common.point(ray, delta)
	if ray.is_colliding():
		var troll = ray.get_collider()
		if Common.testTroll(troll):
			captureMove.setCapturePiece(troll)
			captureMove.set_global_position(troll.get_global_position() - Common.offset)
		else:
			captureMove.queue_free()
	else:
		captureMove.queue_free()

	

func trollDistance(dir):
	var steps = 1
	var stop = false
	while not stop:
		var delta = dir * Common.tileSize * steps
		Common.point(ray, delta)
		if ray.is_colliding():
			var node = ray.get_collider()
			if Common.testTroll(node):
				return steps
			else:
				return -1
		else: 
			steps = steps + 1

func dwarfLine(dir):
	var line = 1
	var nodesExcluded = []
	var delta = dir * Common.tileSize
	var stop = false
	while not stop:
		Common.point(ray, delta * line)
		var node = ray.get_collider()
		if node != null and Common.testDwarf(node):
			line += 1
			ray.add_exception(node)
			nodesExcluded.append(node)
		else:
			stop = true
	for dw in nodesExcluded:
		ray.remove_exception(dw)
	return line
