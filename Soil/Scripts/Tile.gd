extends Resource

class_name Tile

var coords		: Vector2i
var	soil_quality	: int = 0
var	leaf_coverage	: int = 0
var canopy_tree		: int = 0
var under_story		: int = 0
var forest_ground	: int = 0

var canopy_trees		: Array[String] = ["" ,"pau-brasil", "ipê amarelo", "ipê roxo", "ipê branco"]
var understory_trees	: Array[String] = ["" ,"jussara", "coco-preto"]
var ground_plants		: Array[String] = ["" ,"erva de anta", "caête"]

func	_init(_coords : Vector2,_soil_quality : int, _leaf_coverage : int, _canopy_tree : int, 
				_under_story : int, _forest_ground : int) -> void:
	coords = _coords
	soil_quality = _soil_quality
	leaf_coverage = _leaf_coverage
	canopy_tree = _canopy_tree
	under_story = _under_story
	forest_ground = _forest_ground
