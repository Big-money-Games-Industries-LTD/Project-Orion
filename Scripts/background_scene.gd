extends Node2D

var global_time:int = 0
var scenes_list = []
var current_scene_index:int = 1

func seconds_to_ticks(time): #seconds to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
func minutes_to_ticks(time): #minutes to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")*60
func hours_to_ticks(time): #hours to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")*60**2

class Set: #implementation of set(bcs godot don't have one), i need it in player
	var dict={}
	func add(a):
		dict[a] = null
	func remove(a):
		dict.erase(a)
	func has(a):
		dict.has(a)
	func _to_string():
		return str(dict)
	func len():
		return len(dict)
		

class Bed:
	var types_dict = {#preloading plant textures
		'cabbage':{
			'texture': preload("res://Assets/Objects/Plants/cabbage.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.seconds_to_ticks(5),
			'fading_probability': 0},
		'carrot':{
			'texture': preload("res://Assets/Objects/Plants/carrot.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.seconds_to_ticks(5),
			'fading_probability': 0.01}
		}
	var type: String
	var next_step_time: int
	var frame: int
	var frames: int
	var is_faded:bool
	var ready_to_harvest:bool
	var fading_probability: float
	var multiplier: float = 1
	
	func _init(_type):
		type = _type
		if _type != 'empty':
			printerr('Created Bed object with type other than empty')
	
	func update():
		if type == 'empty':#checking if we need to do our daily routines at all
			return
		elif ready_to_harvest:
			return
		elif is_faded:
			return
		elif next_step_time != BackgroundScene.global_time:
			return

		frame += 1
		if frame + 1 == frames:
			ready_to_harvest = true
		else:
			next_step_time = BackgroundScene.global_time + (types_dict[type]['growth_time']/types_dict[type]['frames'])*multiplier
		if randf_range(0,1)<fading_probability:#see if it fades
			is_faded = true
			ready_to_harvest = false
			return
			
	func plant(_type):
		type = _type
		next_step_time = BackgroundScene.global_time + (types_dict[_type]['growth_time']/types_dict[_type]['frames'])*multiplier
		frame = 0
		frames = types_dict[type]['frames']
		is_faded = false
		ready_to_harvest = false
		fading_probability = types_dict[type]['fading_probability']
		
	func water():
		next_step_time = next_step_time-(next_step_time - BackgroundScene.global_time)/2

var beds_list = []
var inventory = [['cabbage_seed', 4], ['carrot_seed', 4], false, false, false]
#[['cabbage_seed', 1], ['cabbage', 3], [false], [false]]
var inventory_pos = 0
func add_to_inventory(object, amount):
	if not inventory[inventory_pos]: #TODO: firstly find same existed object from first slot and if impossible then put it to empty current slot
		inventory[inventory_pos] = [object, amount]
	elif inventory[inventory_pos][0] == object:
		inventory[inventory_pos][1] += amount
	else:
		for idx in inventory.size():
			if not inventory[idx]:
				inventory[idx] = [object, amount]
				break
			elif inventory[idx][0] == object:
				inventory[idx][1] += amount
				break

func remove_from_inventory(position = inventory_pos):
	inventory[position][1] -= 1
	if inventory[position][1] <= 0:
		inventory[position] = false

func _on_timer_timeout():
	print('next day started')#replace with some fancy UI notification
	$day_end_timer.start()
	

func update(timer_flag):#update every known bed and restart timer if needed
	global_time+=1
	for i in beds_list:
		for j in i:
			j.update()
	if timer_flag:
		if not $day_end_timer.is_stopped():
			printerr('Start day timer restarted while it was running')
		$day_end_timer.start()
#	print($day_end_timer.get_time_left())

func day_skip():
	var time_left = $day_end_timer.get_time_left()
	$day_end_timer.stop()
	for i in range(snapped(time_left, 1)): #if player have some time left, we simulate remaining time
		update(false)#NOTE maybe we should decrease fading probability for this case
	update(true)


func _ready():
	randomize()
	scenes_list.append("res://Scenes/home_scene.tscn")
	var dir = DirAccess.open("res://Scenes/field_maps_scenes_only/") #checking how many fields do we have to make appropriate amount of columns in the array, it shoul act like a static array anywhere else in the game exept this place
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":#basicly acts like 'for i in files_in_the_folder'
		scenes_list.append("res://Scenes/field_maps_scenes_only/"+file_name) #add scene to scenes_list so it will have all scenes
		beds_list.append([])
		file_name = dir.get_next()

func _process(_delta):
	if Input.is_action_just_pressed("scene_change_down") and not current_scene_index == 0:#scene changing script; we do ante-list_index_out_of_range check and then change scene
		current_scene_index -= 1
		get_tree().change_scene_to_file(scenes_list[current_scene_index])
	if Input.is_action_just_pressed("scene_change_up") and not current_scene_index == len(scenes_list)-1:#
		current_scene_index += 1
		get_tree().change_scene_to_file(scenes_list[current_scene_index])
	if Input.is_action_just_pressed("scroll_up"):
		inventory_pos -= 1
	if Input.is_action_just_pressed("scroll_down"):
		inventory_pos += 1
	if inventory_pos > 4:
		inventory_pos = 0
	if inventory_pos < 0:
		inventory_pos = 4
	
func _physics_process(_delta):
	update(false)
