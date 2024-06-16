extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	create_plant('cabbage',Vector2(0,0),-2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_plant(type:String, coordinates:Vector2, bed_pointer:int):
	var types_dict = {
		'cabbage':preload("res://Assets/Objects/Plants/cabbage.tscn")
	}
	var plant = types_dict[type].instantiate()
	plant.position = coordinates
	plant.set_meta('bed_pointer',bed_pointer)
	$".".add_child(plant)
