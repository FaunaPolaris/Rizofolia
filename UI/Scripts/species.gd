extends TextureRect

class_name Species

enum species
{
	NO,
	NOS_MOSCADA,
	FIGUEIRA,
	IPE,
	PAU_BRASIL,
	JUSSARA,
	COCO_PRETO,
	ERVA_DE_ANTA,
	CAETE
}

#var speciesType	: Array[String] = Array["Nós Moscada", "Figueira"]

var	specie	: int
var	name_title	: String

func	initialize(_name_title : String) -> void:
	name_title = _name_title
	$hbox/species_name.text = name_title
