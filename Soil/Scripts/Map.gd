extends Node2D

var map_size	: int = 16
var	tiles		: Array[Tile]

func	_ready():
	initTiles(map_size)
	updateDisplayedTiles(tiles)
	
func	initTiles(size):
	var coord : Vector2 = Vector2(0, 0)
	while coord.y < size:
		coord.x = 0
		while coord.x < size:
			var new_tile = Tile.new(Vector2i(coord.x, coord.y), randi_range(0, 4), 0, 0)
			tiles.append(new_tile)
			coord.x += 1
		coord.y += 1
	
func updateDisplayedTiles(input : Array[Tile]):
	for tile in tiles:
		$soil.set_cell(tile.coords, 0, Vector2i(tile.soil_quality, 0))
