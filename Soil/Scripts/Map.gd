extends Node2D

var map_size	: int = 16
var	tiles		: Array[Tile]

func	_ready():
	initTiles(map_size)
	updateDisplayedTiles(tiles)
	
func	initTiles(size):
	var offset = size *  .5
	var coord : Vector2 = Vector2(-offset, -offset)
	
	while coord.y < offset:
		coord.x = -offset
		while coord.x < offset:
			var new_tile = Tile.new(Vector2i(coord.x, coord.y), randi_range(0, 2), randi_range(0, 3),
				randi_range(0, 4), randi_range(0, 2), randi_range(0, 1))
			tiles.append(new_tile)
			coord.x += 1
		coord.y += 1 
	
func updateDisplayedTiles(input : Array[Tile]):
	for tile in tiles:
		$"textures/soil".set_cell(tile.coords, 0, Vector2i(tile.soil_quality, 0))
		$textures/leaf.set_cell(tile.coords, 0, Vector2i(tile.leaf_coverage, 0))
		$textures/canopy.set_cell(tile.coords, 0, Vector2i(tile.canopy_tree, 0))
		$"textures/under-story".set_cell(tile.coords, 0, Vector2i(tile.under_story, 1))
		$"textures/forest-ground".set_cell(tile.coords, 0, Vector2i(tile.under_story, 2))
