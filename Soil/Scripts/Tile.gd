extends Resource

class_name Tile

var coords		: Vector2i
var	soil_quality	: int = 0
var	leaf_coverage	: int = 0
var canopy_tree		: int = 0

func	_init(_coords : Vector2,_soil_quality : int, _leaf_coverage : int, _canopy_tree : int):
	coords = _coords
	soil_quality = _soil_quality
	leaf_coverage = _leaf_coverage
	canopy_tree = _canopy_tree
	
