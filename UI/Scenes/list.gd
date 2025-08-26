extends Control

class_name SpeciesList

var	species_scene	= load("res://UI/Scenes/species.tscn")

var canopy_display		: bool = false
var understory_display	: bool = false
var ground_display		: bool = false

var canopy				: Species
var understory			: Species
var ground				: Species

var tile				: Tile

func	initialize(_tile : Tile) -> void:
	tile = _tile

func _on_canopy_button_down() -> void:
	if not canopy_display:
		canopy_display = true
		print("addying species")
		var new_species = species_scene.instantiate()
		$vbox/canopy.add_child(new_species)
		new_species.add_to_group("canopy_items")
		$vbox/canopy/button.icon = load("res://UI/Assets/arrowDown.png")
		new_species.initialize(tile.canopy_trees[tile.canopy_tree])
	elif canopy_display:
		$vbox/canopy/button.icon = load("res://UI/Assets/arrowUp.png")
		canopy_display = false
		for specie in get_tree().get_nodes_in_group("canopy_items"):
			print("freeing item")
			specie.queue_free()

func _on_button_button_down() -> void:
	if not canopy_display:
		canopy_display = true
		print("addying species")
		var new_species = species_scene.instantiate()
		$vbox/understory.add_child(new_species)
		new_species.add_to_group("understory_items")
		$vbox/understory/button.icon = load("res://UI/Assets/arrowDown.png")
		new_species.initialize(tile.understory_trees[tile.under_story])
	elif canopy_display:
		$vbox/understory/button.icon = load("res://UI/Assets/arrowUp.png")
		canopy_display = false
		for specie in get_tree().get_nodes_in_group("understory_items"):
			print("freeing item")
			specie.queue_free()
	
func _on_ground_button_down() -> void:
	if not canopy_display:
		canopy_display = true
		print("addying species")
		var new_species = species_scene.instantiate()
		$vbox/ground.add_child(new_species)
		new_species.add_to_group("ground_items")
		$vbox/ground/button.icon = load("res://UI/Assets/arrowDown.png")
		new_species.initialize(tile.ground_plants[tile.forest_ground])
	elif canopy_display:
		$vbox/ground/button.icon = load("res://UI/Assets/arrowUp.png")
		canopy_display = false
		for specie in get_tree().get_nodes_in_group("ground_items"):
			print("freeing item")
			specie.queue_free()
