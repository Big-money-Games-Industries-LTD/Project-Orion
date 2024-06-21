extends Node2D

var self_pointer
var player_in_the_area
var plant

func _on_area_2d_body_entered(body):#detect when player enters or leaves our area
	if body is Player:
		player_in_the_area = body
		body.beds_i_touch.add(self)
		print(body.beds_i_touch.len())

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_the_area = false
		body.beds_i_touch.remove(self)
		print(body.beds_i_touch.len())

func _process(_delta):
	var not_more_than_one_bed = %Player.beds_i_touch.len()<2#see if we are the only bed player touches, if not, dont allow him to harvest or to plant anything
	if not_more_than_one_bed and player_in_the_area and plant and BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].ready_to_harvest:
		player_in_the_area.harvest_hint_on()
	elif not_more_than_one_bed and player_in_the_area:
		player_in_the_area.plant_hint_on()
		if Input.is_action_just_pressed('action0'):
			if plant:
				printerr('Planted two plants at once')
			plant = $"..".create_plant('cabbage',self.position,self_pointer) #create plant and put it into our plant variable so we can know wich plant belongs to us

func _ready():
	pass 

func delayed_ready():#we want this to be done after field is ready
	self_pointer = [$"..".self_index,int(self.name.right(1))]
	



