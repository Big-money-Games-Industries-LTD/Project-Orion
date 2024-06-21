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
	var bed_in_beds_list = BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]]
	if not_more_than_one_bed and player_in_the_area and plant and (bed_in_beds_list.ready_to_harvest or bed_in_beds_list.is_faded):
		player_in_the_area.harvest_hint_on()#allowing him to harvest crop if it is ready or faded
		if Input.is_action_just_pressed('action0'):
			if bed_in_beds_list.ready_to_harvest or bed_in_beds_list.is_faded: 
				if bed_in_beds_list.ready_to_harvest:
					BackgroundScene.add_to_inventory('cabbage', 1) #TODO: add a more_than_one prob.
				plant = false
				$"..".remove_plant(self_pointer)

	elif not_more_than_one_bed and player_in_the_area and not plant:
		player_in_the_area.plant_hint_on()#allowing him to plant if nothing is planted already
		if Input.is_action_just_pressed('action0'):
			if plant:
				printerr('Planted two plants at once')#we need to replace this with menu
			plant = $"..".create_plant('cabbage',self.position,self_pointer) #create plant and put it into our plant variable so we can know wich plant belongs to us

func _ready():
	pass 

func delayed_ready():#we want this to be done after field is ready
	self_pointer = [$"..".self_index,int(self.name.right(1))]
	



