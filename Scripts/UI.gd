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
func _process(_delta):
	$Main_UI/inventory.frame = BackgroundScene.inventory_pos
	global_position = %Camera2D.get_screen_center_position() + Vector2(-960, -540) #attach UI to screen
	var enumerate = 0
	for i in $"Main_UI/slots".get_children():
		if BackgroundScene.inventory[enumerate]:
			i.texture = icons[BackgroundScene.inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.inventory[enumerate][1])
			enumerate += 1
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
