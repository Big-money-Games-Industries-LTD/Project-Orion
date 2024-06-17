extends Node2D

var global_time:int = 0

func tts(time): #seconds to tics
	return time*ProjectSettings.get_setting("/common/physics_ticks_per_second")
func ttm(time): #minutes to tics
	return time*ProjectSettings.get_setting("/common/physics_ticks_per_second")*60
func tth(time): #hours to tics
	return time*ProjectSettings.get_setting("/common/physics_ticks_per_second")*60**2

class Bed:
	var types_dict = {#preloading plant textures
		'cabbage':{
			'texture': preload("res://Assets/Objects/Plants/cabbage.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.ttm(7),
			'fading_probability': 0.1},
		'carrot':{
			'texture': preload("res://Assets/Objects/Plants/carrot.tscn"),
			'frames': 6,
			'growth_time': BackgroundScene.ttm(5),
			'fading_probability': 0.1}
		}
	var type: String
	var next_step_time: int
	var frame: int
	var frames: int
	var is_faded:bool
	var ready_to_harvest:bool
	var fading_probability: float
	var multiplier: float
	
	func _init(_type):
		type = _type
	
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
			next_step_time = BackgroundScene.global_time + (types_dict[type]['growth_time']/types_dict[type]['frames'])*(frame+1)*2*multiplier
		if randf_range(0,1)<fading_probability:#see if it fades
			is_faded = true
			ready_to_harvest = false
			return
			
	func plant(_type):
		type = _type
		next_step_time = BackgroundScene.global_time + (types_dict[type]['growth_time'] / types_dict[type]['frames']) * multiplier * 2
		frame = 0
		is_faded = false
		ready_to_harvest = false
		fading_probability = types_dict[type]['fading_probability']
		
	func water():
		next_step_time = next_step_time-(next_step_time - BackgroundScene.global_time)/2

var beds_list = []


func _on_timer_timeout():
	print('next day started')#replace with some fancy UI notification
	$day_end_timer.start()
	

func update(timer_flag):#update every known bed and restart timer if needed
	for i in beds_list:
		for j in i:
			j.update(global_time)
	if timer_flag:
		if not $day_end_timer.is_stopped():
			printerr('Start day timer restarted while it was running')
		$day_end_timer.start()

func day_skip():
	var time_left = $day_end_timer.get_time_left()
	$day_end_timer.stop()
	for i in range(snapped(time_left, 1)): #if player have some time left, we simulate remaining time
		update(false)#NOTE maybe we should decrease fading probability for this case
	update(true)


func _ready():
	randomize()
	var dir = DirAccess.open("res://Scenes/field_maps_scenes_only/") #checking how many fields do we have to make appropriate amount of columns in the array, it shoul act like a static array anywhere else in the game exept this place
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		beds_list.append([])
		file_name = dir.get_next()
	


func _process(delta):
	pass
	
func _physics_process(delta):
	global_time+=1
	for i in beds_list:
		for j in beds_list:
			j.time(global_time)
	update(false)
