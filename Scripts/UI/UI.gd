extends Control

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
	'leica': preload("res://Raw assets/Leica.png"),
	'transparent': preload("res://Assets/Textures/Transparent.png")
}

func get_pos():
	return $"..".position

func change_UI(_name):
	for i in get_children():
		if not i.name == _name:
			i.visible = false
		else:
			current_UI = _name
			i.visible = true

func _on_blackout_animation_player_animation_finished(_anim_name):
	BackgroundScene.is_movement_available = true
	
func _process(_delta):
	BackgroundScene.current_UI = current_UI
	$Main_UI/Debug_Info.text = 'Day timer: ' + str(round(BackgroundScene.get_child(0).time_left)) + '\n' + "Global time: " + str(BackgroundScene.global_time) 
	global_position = %Camera2D.get_screen_center_position() + Vector2(-960, -540) * Vector2(1/1.3, 1/1.3) #attach UI to screen
			
func _ready():
	if BackgroundScene.was_the_scene_loaded_after_cutscene:
		change_UI("Loader_UI")
	else:
		change_UI("Main_UI")
	BackgroundScene.current_UI = current_UI
