extends TileMap



var dwarf_start_tile = [Vector2(5, 0), Vector2(6, 0), Vector2(8, 0), Vector2(9, 0),
						Vector2(0, 5), Vector2(0, 6), Vector2(0, 8), Vector2(0, 9),
						Vector2(14, 5), Vector2(14, 6), Vector2(14, 8), Vector2(14, 9),
						Vector2(5, 14), Vector2(6, 14), Vector2(8, 14), Vector2(9, 14),
						Vector2(1, 4), Vector2(2, 3), Vector2(3, 2), Vector2(4, 1),
						Vector2(10, 1), Vector2(11, 2), Vector2(12, 3), Vector2(13, 4),
						Vector2(1, 10), Vector2(2, 11), Vector2(3, 12), Vector2(4, 13),
						Vector2(10, 13), Vector2(11, 12), Vector2(12, 11), Vector2(13, 10)]

var troll_start_tile = [Vector2(6, 6),
						Vector2(6, 7),
						Vector2(6, 8),
						Vector2(7, 6),
						Vector2(7, 8),
						Vector2(8, 6),
						Vector2(8, 7),
						Vector2(8, 8)]
						
						


onready var dwarfPiece = preload("res://Pieces/Dwarf.tscn")
onready var trollPiece = preload("res://Pieces/Troll.tscn")
onready var dwarfContainer = $Dwarves
onready var trollContainer = $Trolls

func _ready():
	reset()

func reset():
	clearBoard()
	for tile in dwarf_start_tile:
		addDwarf(tile)
	for tile in troll_start_tile:
		addTroll(tile)
	activate(dwarfContainer)
	deactivate(trollContainer)
			

func addDwarf(tilePos):
	var globalPos = map_to_world(tilePos) + Common.offset
	var dwarf = dwarfPiece.instance()
	dwarfContainer.add_child(dwarf)
	dwarf.set_global_position(globalPos)
	
func addTroll(tilePos):
	var globalPos = map_to_world(tilePos) + Common.offset
	var troll = trollPiece.instance()
	trollContainer.add_child(troll)
	troll.set_global_position(globalPos)
	
func clearBoard():
	for node in dwarfContainer.get_children():
		node.queue_free()
	for node in trollContainer.get_children():
		node.queue_free()

func activate(pieceSet):
	for child in pieceSet.get_children():
		child.activate()

func deactivate(pieceSet):
	for child in pieceSet.get_children():
		child.deactivate()

func toggle(finished):
	if finished == "dwarf":
		activate(trollContainer)
		deactivate(dwarfContainer)
	else:
		activate(dwarfContainer)
		deactivate(trollContainer)
