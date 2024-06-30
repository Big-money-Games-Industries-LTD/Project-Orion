extends Node2D

const types_dict = {#preloading plant textures
		'cabbage':preload('res://Assets/Objects/Plants/cabbage.tscn'),
		'carrot':preload('res://Assets/Objects/Plants/carrot.tscn')
	}

var self_index = int(self.name.right(1))
var frames:int
var beds_list
 
func create_plant(type:String, coordinates:Vector2, bed_pointer):#bed pointer is [field_number, bed_number]
	BackgroundScene.beds_list[bed_pointer[0]][bed_pointer[1]].plant(type)
	return create_plant_sprite(type, coordinates, bed_pointer)

func create_plant_sprite(type:String, coordinates:Vector2, bed_pointer):
	var plant = types_dict[type].instantiate()#instantiate reqred crop texture
	plant.position = coordinates
	plant.set_meta('bed_pointer',bed_pointer)
	plant.add_to_group('Plants')
	$".".add_child(plant)
	return plant

func get_plant(bed_pointer):
	var plants_list = get_tree().get_nodes_in_group('Plants')
	for i in plants_list:
		if i.get_meta('bed_pointer') == bed_pointer:
			return i
	printerr('Attempted to get nonexisting plant')

func remove_plant(bed_pointer):
	get_plant(bed_pointer).queue_free()

func update_plant_frame(frame_number, bed_pointer): #HACK: Delete or complete
	pass
	

func _on_border_left_body_entered(body):
	if body is Player:
		BackgroundScene.current_scene_index = 0
		get_tree().change_scene_to_file(BackgroundScene.scenes_list[BackgroundScene.current_scene_index])
		BackgroundScene.position_saver = false

func _on_border_right_body_entered(body):
	if body is Player:
		BackgroundScene.current_scene_index = len(BackgroundScene.scenes_list)-1
		get_tree().change_scene_to_file(BackgroundScene.scenes_list[BackgroundScene.current_scene_index]) #FIXME: leads to errors
		BackgroundScene.position_saver = false

func _ready():
	beds_list = get_tree().get_nodes_in_group('Beds')
	if not BackgroundScene.beds_list[self_index]: #make BackgroundScene know about our beds unless it knows already
		for i in beds_list:
			BackgroundScene.beds_list[self_index].append(BackgroundScene.Bed.new('empty'))
	for i in beds_list:
		i.delayed_ready()
	%Player.delayed_ready()
