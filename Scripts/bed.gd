extends Node2D

var self_pointer

func _on_area_2d_body_entered(body):
	print(body)
	if body is Player:
		print('body_entered')
		%Player.Ui.plant_hint_on()

func _process(delta):
	pass

func _ready():
	pass 

func delayed_ready():
	self_pointer = [$"..".self_index,self.name.right(1)]
