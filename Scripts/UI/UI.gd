extends Node2D

var plant_hint_timer = 0
var harvest_hint_timer = 0
var current_UI
const icons = {
	'cabbage_seed': preload("res://Assets/Textures/Plants/Seed/Cabbage_seed.png"),
	'carrot_seed': preload("res://Assets/Textures/Plants/Seed/Carrot_seed.png"),
	'wheat_seed': preload("res://Assets/Textures/Plants/Seed/Wheat_seeds.png"),
	'cabbage': preload("res://Assets/Textures/Plants/Result/Cabbage_result.png"),
	'carrot': preload("res://Assets/Textures/Plants/Result/Carrot_result.png"),
	'wheat': preload("res://Assets/Textures/Plants/Result/Wheat_result.png"),
	'transparent': preload("res://Assets/Textures/Transparent.png")
}

func change_UI(_name):
	for i in get_children():
		if not i.name == _name:
			i.visible = false
		else:
			current_UI = _name
			i.visible = true

	
func _process(_delta):
	BackgroundScene.current_UI = current_UI
	$Main_UI/Day_timer.text = str(BackgroundScene.get_child(0).time_left)
	global_position = %Camera2D.get_screen_center_position() + Vector2(-960, -540) #attach UI to screen
			
func _ready():
	change_UI("Main_UI")
	BackgroundScene.current_UI = current_UI
