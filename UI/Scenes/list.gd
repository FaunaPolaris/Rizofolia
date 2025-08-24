extends Control

class_name SpeciesList

var	species_scene	= preload("res://UI/Scenes/species.tscn")

var canopy		: Species
var understory	: Species
var ground		: Species

func	initialize(_canopy : Species, _understory : Species, _ground : Species) -> void:
	canopy = _canopy
	understory = _understory
	ground = _ground

func _on_canopy_button_down() -> void:
	var new_species = species_scene.instantiate()
	new_species.initilize("pau-brasil")
	print("addying species")
	$vbox/canopy.add_child(new_species)
