extends Node2D

var plant_hint_timer = 0
var harvest_hint_timer = 0
var icons = {
	'cabbage_seed': preload("res://Assets/Textures/Cabbage_seed.png"),
	'carrot_seed': preload("res://Assets/Textures/Carrot_seed.png"),
	'wheat_seed': preload("res://Assets/Textures/Wheat_seeds.png"),
	'cabbage': preload("res://Assets/Textures/Cabbage_result.png"),
	'carrot': preload("res://Assets/Textures/Carrot_result.png"),
	'wheat': preload("res://Assets/Textures/Wheat_result.png"),
	'transparent': preload("res://Assets/Textures/Transparent.png")
}
func main_UI():
	for i in $".".get_children():
		if not i.name == 'Main_UI':
			i.visible = false
		else:
			i.visible = true
			
func tractorman_UI():
	for i in $".".get_children():
		if not i.name == 'Tractorman':
			i.visible = false
		else:
			i.visible = true
	
func loader_UI():
	for i in $".".get_children():
		if not i.name == 'Loader':
			i.visible = false
		else:
			i.visible = true
	
func pallet_UI():
	for i in $".".get_children():
		if not i.name == 'Pallet':
			i.visible = false
		else:
			i.visible = true

func update_UI():
	var enumerate = 0
	for i in $"Main_UI/slots".get_children():
		if BackgroundScene.inventory[enumerate]:
			i.texture = icons[BackgroundScene.inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
	enumerate = 0
	for i in $"Pallet/Inventory_slots".get_children():
		if BackgroundScene.inventory[enumerate]:
			i.texture = icons[BackgroundScene.inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
	enumerate = 0
	for i in $"Pallet/Pallet_slots".get_children():
		if BackgroundScene.pallet_inventory[enumerate]:
			i.texture = icons[BackgroundScene.pallet_inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.pallet_inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
	
func _process(_delta):
	$Main_UI/inventory.frame = BackgroundScene.inventory_pos
	global_position = %Camera2D.get_screen_center_position() + Vector2(-960, -540) #attach UI to screen
	update_UI()
			
func _ready():
	main_UI()
	update_UI()
