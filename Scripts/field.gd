extends Node2D

const types_dict = {#preloading plant textures
		'cabbage':preload('res://Assets/Objects/Plants/cabbage.tscn'),
		'carrot':preload('res://Assets/Objects/Plants/carrot.tscn')
	}

var self_index = int(self.name.right(1))
var frames:int
var beds_list
 
func create_plant(type:String, coordinates:Vector2, bed_pointer):#bed pointer is [field_number, bed_number]
	var plant = types_dict[type].instantiate()#instantiate reqred crop texture
	plant.position = coordinates
	plant.set_meta('bed_pointer',bed_pointer)
	plant.add_to_group('Plants')
	$".".add_child(plant)
	BackgroundScene.beds_list[bed_pointer[0]][bed_pointer[1]].plant(type)
	return plant

func get_plant(bed_pointer):
	var plants_list = get_tree().get_nodes_in_group('Plants')
	for i in plants_list:
		if i.get_meta('bed_pointer') == bed_pointer:
			return i
	printerr('Attempted to get nonexisting plant')

func remove_plant(bed_pointer):
	get_plant(bed_pointer).queue_free()

func update_plant_frame(frame_number, bed_pointer):
	pass
	

func _ready():
	beds_list = get_tree().get_nodes_in_group('Beds')
	if not BackgroundScene.beds_list[self_index]: #make BackgroundScene know about our beds unless it knows already
		for i in beds_list:
			BackgroundScene.beds_list[self_index].append(BackgroundScene.Bed.new('empty'))
	for i in beds_list:
		i.delayed_ready()


func _process(delta):
	pass
	#print(BackgroundScene.beds_list[0][0].frame)
