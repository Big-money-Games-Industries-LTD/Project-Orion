extends Node2D

var self_pointer
var player_in_the_area = false
var plant = null

func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_the_area = body
		body.beds_i_touch.add(self)
		print(body.beds_i_touch.len())

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_the_area = false
		body.beds_i_touch.remove(self)
		print(body.beds_i_touch.len())

func _process(delta):
	var not_more_than_one_bed = %Player.beds_i_touch.len()<2
	if not_more_than_one_bed and player_in_the_area and plant and BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].ready_to_harvest:
		player_in_the_area.harvest_hint_on()
	elif not_more_than_one_bed and player_in_the_area:
		player_in_the_area.plant_hint_on()
		if Input.is_action_just_pressed('action0'):
			plant = $"..".create_plant('cabbage',self.position,self_pointer)

func _ready():
	pass 

func delayed_ready():
	self_pointer = [$"..".self_index,int(self.name.right(1))]
	



