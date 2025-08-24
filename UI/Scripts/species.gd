extends TextureRect

class_name Species

var	name_title	: String

func	initialize(_name_title : String) -> void:
	name_title = _name_title
	$hbox/species_name.text = name_title
