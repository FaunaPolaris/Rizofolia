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
			var new_tile = Tile.new(Vector2i(coord.x, coord.y), randi_range(0, 2), randi_range(0, 2), 0)
			tiles.append(new_tile)
			coord.x += 1
		coord.y += 1
	
func updateDisplayedTiles(input : Array[Tile]):
	for tile in tiles:
		$soil.set_cell(tile.coords, 0, Vector2i(tile.soil_quality, 0))
		$leaf.set_cell(tile.coords, 0, Vector2i(tile.leaf_coverage, 0))
