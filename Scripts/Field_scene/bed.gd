extends Node2D

var self_pointer
var player_in_the_area
var plant

func _on_area_2d_body_entered(body):#detect when player enters or leaves our area
	if body is Player:
		player_in_the_area = body
		body.beds_i_touch.add(self)

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_the_area = false
		body.beds_i_touch.remove(self)

func _on_timer_animation_finished():
	var bed_in_beds_list = BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]]
	if bed_in_beds_list.ready_to_harvest:
		BackgroundScene.add_to_inventory(bed_in_beds_list.type, 1) #TODO: add a more_than_one prob.
		BackgroundScene.add_to_inventory(bed_in_beds_list.type + "_seed", 1)
	BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].type = 'empty'
	plant = false
	$"..".remove_plant(self_pointer)
	$Timer.visible = false

func set_harvesting_time(target):
	$Timer.set_animation_speed('default', target/37)

func _process(_delta):
	var not_more_than_one_bed = %Player.beds_i_touch.len()<2#see if we are the only bed player touches, if not, dont allow him to harvest or plant anything
	var bed_in_beds_list = BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]]
	if not_more_than_one_bed and player_in_the_area and plant and (bed_in_beds_list.ready_to_harvest or bed_in_beds_list.is_faded) and not $Timer.is_playing():
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("default")
		if Input.is_action_just_pressed('action0'):
			if bed_in_beds_list.ready_to_harvest or bed_in_beds_list.is_faded:
				$AnimatedSprite2D.hide()
				$Timer.visible = true
				$Timer.play()
#				$AnimationPlayer.play('animation')
				

	elif not_more_than_one_bed and player_in_the_area and not plant and not $Timer.is_playing() and $Aqueduct.visible:
		if BackgroundScene.inventory[BackgroundScene.inventory_pos]:
			if BackgroundScene.inventory[BackgroundScene.inventory_pos][0].split('_', true).size() > 1:
				if BackgroundScene.inventory[BackgroundScene.inventory_pos][0].split('_', true)[1] == 'seed':
					$AnimatedSprite2D.visible = true
					$AnimatedSprite2D.play("default")
					if Input.is_action_just_pressed('action0'):
						if plant:
							printerr('Planted two plants at once')#we need to replace this with menu
						plant = $"..".create_plant(BackgroundScene.inventory[BackgroundScene.inventory_pos][0].split('_', true)[0],self.position,self_pointer) #create plant and put it into our plant variable so we can know wich plant belongs to us
						BackgroundScene.remove_from_inventory()
				else:
					$AnimatedSprite2D.visible = false
					$AnimatedSprite2D.stop()
			else:
				$AnimatedSprite2D.visible = false
				$AnimatedSprite2D.stop()
		else:
			$AnimatedSprite2D.visible = false
			$AnimatedSprite2D.stop()
	else:
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D.stop()
	
	
	if BackgroundScene.inventory[BackgroundScene.inventory_pos] and not (bed_in_beds_list.ready_to_harvest or bed_in_beds_list.is_faded):
		if BackgroundScene.inventory[BackgroundScene.inventory_pos][0] == 'leica':
			if  not_more_than_one_bed and player_in_the_area and plant and not $Timer.is_playing() and not BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].has_been_watered:
				$AnimatedSprite2D.visible = true
				$AnimatedSprite2D.play("default")
				if Input.is_action_just_pressed('action0'):
					BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].water()
			else:
				$AnimatedSprite2D.visible = false
				$AnimatedSprite2D.stop()
	
	if (Input.is_action_just_released("action0") and $Timer.is_playing()) or not player_in_the_area:
		$Timer.stop()
		$Timer.visible = false
	
func _ready():
	pass 

func delayed_ready():#we want this to be done after field is ready
	self_pointer = [$"..".self_index,int(self.name.right(1))]
	var self_type = BackgroundScene.beds_list[self_pointer[0]][self_pointer[1]].type
	if self_type != 'empty':
		plant = $"..".create_plant_sprite(self_type,self.position,self_pointer)
