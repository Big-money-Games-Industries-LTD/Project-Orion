extends Node2D
var absolute_time:int = 0

class Bed:
	var type
	var time_remaining:int
	var fading_probability:float
	var is_faded:bool = false
	var ready_to_harvest:bool = false
	
	func _init(_type, _time_remaining:int, _fading_probability:float):
		type = _type
		time_remaining = _time_remaining
		fading_probability = _fading_probability
	
	func update():
		if type == 'empty_bed':#checking if we need to do our daily routines at all
			return
		if is_faded:
			return
		
		if randf_range(0,1)<fading_probability:#see if it fades
			is_faded = true
			ready_to_harvest = false
			fading_probability = 0
			time_remaining = -1#to prevent it from making crops ready to harvest
			return
			
		if time_remaining and not ready_to_harvest:#decreasing timer if it isn't zero and making harvesting availible if it is
			time_remaining-=1
		if not time_remaining and not ready_to_harvest:
			ready_to_harvest = true
			

var beds_list = []


func _on_timer_timeout():
	print('next day started')#replace with some fancy UI notification
	$day_end_timer.start()
	

func update(timer_flag):#update every known bed and restart timer if needed
	for i in beds_list:
		for j in i:
			j.update()
	if timer_flag:
		if not $day_end_timer.is_stopped():
			printerr('Attempted to start day timer while it was running')
			push_error('Attempted to start day timer while it was running')
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
	absolute_time+=1
	update(false)
