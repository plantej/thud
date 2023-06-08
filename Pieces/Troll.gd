extends "res://Pieces/BasePiece.gd"

onready var normalMove = preload("res://Moves/TrollMove.tscn")
onready var captureMove = preload("res://Moves/TrollCapture.tscn")
onready var specialMove = preload("res://Moves/TrollSpecial.tscn")
onready var button = get_node("CenterContainer/TextureButton")
#onready var normalMove = preload("res://Moves/BaseMove.tscn")

func activate():
#	button.set_disabled(false)
	button.set_button_mask(BUTTON_MASK_LEFT)

func deactivate():
	button.set_button_mask(BUTTON_MASK_RIGHT)
#	button.set_disabled(true)

func spawnMove(dir):
	Common.point(ray, dir * Common.tileSize)
	if not ray.is_colliding():
		var movePos = self.get_global_position() + (dir * Common.tileSize)
		createMove(movePos)

func createMove(newPos):
	var moveInstance = normalMove.instance()
	moves.add_child(moveInstance)
	moveInstance.set_global_position(newPos - Common.offset)
	moveInstance.setHomePiece(self)


func buildCaptures():
	var capturecount = 0
	for dir in Common.dirs:
		var dwarf = getDwarfNode(dir)
		if dwarf != null :
			spawnCapture(dwarf)
			capturecount += 1
	if capturecount == 0:
		get_tree().call_group_flags(get_tree().GROUP_CALL_REALTIME, "board", "toggle", "troll")

func spawnCapture(node):
	var captureInstance = captureMove.instance()
	moves.add_child(captureInstance)
	captureInstance.set_global_position(node.get_global_position() - Common.offset)
	captureInstance.setHomePiece(self)
	captureInstance.setCapturePiece(node)
		
func getDwarfNode(dir):
	var node = null
	Common.point(ray, dir * Common.tileSize)
	var colliding = ray.is_colliding()
	if colliding:
		var foundNode = ray.get_collider()
		if Common.testDwarf(foundNode):
			node = foundNode
	return node

func spawnSpecialMove(dir):
	var trollLine = findTrollLine(dir * -1)
	if trollLine > 1:
		trollLine += 1
		for dist in range(1,trollLine):
			var currentDistance = dir * dist * Common.tileSize
			Common.point(ray, currentDistance)
			if ray.is_colliding():
				break
			else:
				var spec = specialMove.instance()
				moves.add_child(spec)
				spec.set_global_position(self.get_global_position() + 
						currentDistance - Common.offset)
				spec.setHomePiece(self)
				spec.validate()
			

func findTrollLine(dir):
	var line = 1
	var nodesExcluded = []
	var delta = dir * Common.tileSize
	var stop = false
	while not stop:
		Common.point(ray, delta * line)
		if ray.is_colliding():
			var node = ray.get_collider()
			if Common.testTroll(node):
				line += 1
				ray.add_exception(node)
				nodesExcluded.append(node)
			else:
				stop = true
		else:
			stop = true

	for nod in nodesExcluded:
		ray.remove_exception(nod)
	return line
