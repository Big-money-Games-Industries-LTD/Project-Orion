extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($day_end_timer.time_left)


func _on_timer_timeout():
	daily_update()

func daily_update():
	$day_end_timer.start()
	print('daily_update')

func day_skip():
	$day_end_timer.stop()
	daily_update()
	print('day_skip')
