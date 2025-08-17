extends Label

func	initialize(tile: Tile) -> void:
	text = str("solo: ", findSoilQuality(tile), "\nespécies: ", findSpeciesQuantity(tile))
	
func	findSoilQuality(tile : Tile) -> String:
	if tile.soil_quality == 0:
		return (str("pobre"))
	elif tile.soil_quality == 1:
		return (str("médio"))
	return (str("rico"))
	
func	findSpeciesQuantity(tile : Tile) -> String:
	var output	: int = 0
	
	if tile.canopy_tree:
		output += 1
	if tile.forest_ground:
		output += 1
	if tile.under_story:
		output += 1
	return (str(output))
