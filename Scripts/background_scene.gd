extends Node2D

const day_duration = 420
var global_time:int = 0
var scenes_list = []
var current_scene_index:int = 1
var is_movement_available: bool = true
var position_saver
var scene_saver = false
var current_UI
var multiplier: float = 1
var fading_probability: float = 0.1
var increased_harvest_probability:float = 0
var increased_harvest_increment:int = 1
var was_the_scene_loaded_after_cutscene: bool #for delivery cutscene
var before_cutscene_position_saver: Vector2 #for delivery cutscene
var money:int = 0
var current_load_scene = null
var aqueducts_in_fields = []
var harvesting_time:float = 2

func seconds_to_ticks(time): #seconds to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
func minutes_to_ticks(time): #minutes to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")*60
func hours_to_ticks(time): #hours to tics
	return time*ProjectSettings.get_setting("physics/common/physics_ticks_per_second")*60**2

var delivery_duration = seconds_to_ticks(day_duration*2)
var is_delivery_started = false

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
			'growth_time': BackgroundScene.seconds_to_ticks(5)},
		'carrot':{
			'texture': preload("res://Assets/Objects/Plants/carrot.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.seconds_to_ticks(5)},
		'wheat':{
			'texture': preload("res://Assets/Objects/Plants/wheat.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.seconds_to_ticks(5)}
		}
	var type: String
	var next_step_time: int
	var frame: int
	var frames: int
	var is_faded:bool
	var ready_to_harvest:bool
	var has_been_watered:bool
	
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
		elif next_step_time > BackgroundScene.global_time: # if next_step_time less than global then run update
			return

		frame += 1
		if frame + 1 == frames:
			ready_to_harvest = true
		else:
			next_step_time += (types_dict[type]['growth_time']/types_dict[type]['frames'])*BackgroundScene.multiplier
			print('frames:' + str(types_dict[type]['frames']))
			print('growth time:' + str(types_dict[type]['growth_time']))
			print('Global time:' + str(BackgroundScene.global_time))
			print('Global time + (growth time/frames) = ' + str(next_step_time))
			if randf_range(0,1)<BackgroundScene.fading_probability and not has_been_watered:#see if it fades
				is_faded = true
				ready_to_harvest = false
			has_been_watered = false
			print(has_been_watered)
			if next_step_time < BackgroundScene.global_time:
				print("startred by recursion due to:")
				print("Next step: " + str(next_step_time))
				print("global time: " + str(BackgroundScene.global_time))
				update()
			else:
				return
			
	func plant(_type):
		type = _type
		next_step_time = BackgroundScene.global_time + (types_dict[_type]['growth_time']/types_dict[_type]['frames'])*BackgroundScene.multiplier
		print("Planted. Next step: " + str(next_step_time))
		frame = 0
		frames = types_dict[type]['frames']
		is_faded = false
		ready_to_harvest = false
#		fading_probability = 0.1
		
	func water():
		next_step_time = next_step_time-(next_step_time - BackgroundScene.global_time)/2
		has_been_watered = true
	
	

var beds_list = []

#////////////////////////////////////////////////////////////////////////////
#///////////////////INVENTORY SECTION////////////////////////////////////////
#////////////////////////////////////////////////////////////////////////////
var inventory = [['cabbage_seed', 4], ['carrot_seed', 4], ['wheat_seed', 4], ['leica', 1], ['wheat', 1]]
#[['cabbage_seed', 1], ['cabbage', 3], [false], [false]]
var inventory_pos = 0
func add_to_inventory(object, amount = 1):
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

func remove_from_inventory(pos = inventory_pos, amount = 1):
	inventory[pos][1] -= amount
	if inventory[pos][1] <= 0:
		inventory[pos] = false

		
#////////////////////////////////////////////////////////////////////////////
#///////////////////PALLET SECTION////////////////////////////////////////
#////////////////////////////////////////////////////////////////////////////
var pallet_inventory = [false, false, false, false, false, false, false, false, false, false]
const prices = {
	"wheat": 15,
	"carrot": 25,
	"cabbage": 40,
	"wheat_seed": 10,
	"carrot_seed": 15,
	"cabbage_seed": 25
}
func pallet_inventory_amount(is_full = false):
	var counter = 0
	for i in pallet_inventory:
		if i:
			counter += 1
	if is_full:
		if counter == pallet_inventory.size():
			return true
		else:
			return false
	else:
		return counter
		
func pallet_inventory_price():
	var price = 0
	for i in pallet_inventory:
		if i:
			if i[0] in prices:
				price += prices[i[0]] * i[1]
	return price


func sell():
	var enumerate = 0
	for i in pallet_inventory:
		if i:
			if i[0] in prices:
				money += prices[i[0]] * i[1]
				pallet_inventory[enumerate] = false
		enumerate += 1
					
		
func add_to_pallet_inventory(object, _idx, amount = 1):
	for idx in pallet_inventory.size():
		if not pallet_inventory[idx]:
			pallet_inventory[idx] = [object, amount]
			remove_from_inventory(_idx, amount)
			break
		elif pallet_inventory[idx][0] == object:
			pallet_inventory[idx][1] += amount
			remove_from_inventory(_idx, amount)
			break
			
			
func remove_from_pallet_inventory(pos, amount = 1):
	pallet_inventory[pos][1] -= amount
	if pallet_inventory[pos][1] <= 0:
		pallet_inventory[pos] = false


func start_delivery():
	is_delivery_started = BackgroundScene.global_time + delivery_duration

func _on_timer_timeout():
	print('next day started')#replace with some fancy UI notification
	$day_end_timer.start()
	

func update():#update every known bed and restart timer if needed
	global_time+=1
	for i in beds_list:
		for j in i:
			j.update()

#	print($day_end_timer.get_time_left())

func day_skip():
	var time_left = seconds_to_ticks($day_end_timer.get_time_left())
	$day_end_timer.stop()
	global_time += time_left-1
	update()
	$day_end_timer.start()


func _ready():
	randomize()
	$day_end_timer.wait_time = day_duration
	$day_end_timer.start()
	scenes_list.append("res://Scenes/Load.tscn")
	var dir = DirAccess.open("res://Scenes/fields/") #checking how many fields do we have to make appropriate amount of columns in the array, it shoul act like a static array anywhere else in the game exept this place
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":#basicly acts like 'for i in files_in_the_folder'
		scenes_list.append("res://Scenes/fields/"+file_name) #add scene to scenes_list so it will have all scenes
		beds_list.append([])
		file_name = dir.get_next()
	scenes_list.append("res://Scenes/home_scene.tscn")
	for i in scenes_list:
		aqueducts_in_fields.append(0)


func _process(_delta):
	if Input.is_action_just_pressed("scroll_up") and current_UI == 'Main_UI':
		inventory_pos -= 1
	if Input.is_action_just_pressed("scroll_down") and current_UI == 'Main_UI':
		inventory_pos += 1
	if inventory_pos > 4:
		inventory_pos = 0
	if inventory_pos < 0:
		inventory_pos = 4
	if is_delivery_started:
		if is_delivery_started == global_time:
			is_delivery_started = false
			if current_load_scene:
				current_load_scene.on_delivery_ends()
	print(harvesting_time)

func _physics_process(_delta):
	update()
