extends Node2D

const types_dict = {#preloading plant textures
		'cabbage':preload("res://Assets/Objects/Plants/cabbage.tscn")
	}

var self_index = int(self.name.right(1))

func _ready():
	if not BackgroundScene.beds_list[self_index]: #make BackgroundScene know about our beds unless it knows already
		var beds_list_local = get_tree().get_nodes_in_group('Beds')
		for i in beds_list_local:
			BackgroundScene.beds_list[self_index].append(BackgroundScene.Bed.new('empty_bed',-1,float(0)))
 


func _process(delta):
	pass

func create_plant(type:String, coordinates:Vector2, bed_pointer:int):#bed pointer is ether bed.get_instance_id() or just something like [field_number, bed_number]; pretty much anything that we can use to find the bed
	var plant = types_dict[type].instantiate()
	plant.position = coordinates
	plant.set_meta('bed_pointer',bed_pointer)#if we stick to the second variant, dont forget to change meta type to 'list'
	$".".add_child(plant)
