extends Node

var tileSize = 42

var N = Vector2(0,-1)
var S = Vector2(0,1)
var E = Vector2(1,0)
var W = Vector2(-1,0)
var NE = Vector2(1, -1)
var NW = Vector2(-1, -1)
var SE = Vector2(1, 1)
var SW = Vector2(-1, 1)

var dirs = [N, S, E, W, NE, NW, SE, SW]

var offset = Vector2(tileSize/2, tileSize/2)

func testTroll(node):
	if node.is_class("Area2D"):
		return node.isTroll()
	return false

func testDwarf(node):
	if node.is_class("Area2D"):
		return node.isDwarf()
	return false

func point(ray, pos):
	ray.set_cast_to(pos)
	ray.force_raycast_update()
