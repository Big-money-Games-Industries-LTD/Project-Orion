extends Node2D

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
	
	func daily_update():
		if type == 'empty_bed':#checking if we need to do our daily routines at all
			return
		if is_faded:
			return
		
		if randf_range(0,1)<fading_probability:#see if it fades
			is_faded = true
			ready_to_harvest = false
			return
			
		if time_remaining:#decreasing timer if it isn't zero and making harvesting availible if it is
			time_remaining-=1
		if not time_remaining:
			ready_to_harvest = true
			
		


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	daily_update()

func daily_update():
	$day_end_timer.start()

func day_skip():
	$day_end_timer.stop()
	daily_update()
