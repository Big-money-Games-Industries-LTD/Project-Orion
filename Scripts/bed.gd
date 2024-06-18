extends Node2D

var self_pointer
var player_in_the_area = false

func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_the_area = body

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_the_area = false

func _process(delta):
	if player_in_the_area:
		player_in_the_area.plant_hint_on()
		if Input.is_action_just_pressed('action0'):
			print(self_pointer)
			$"..".create_plant('cabbage',self.position,self_pointer)

func _ready():
	pass 

func delayed_ready():
	self_pointer = [$"..".self_index,int(self.name.right(1))]
	



