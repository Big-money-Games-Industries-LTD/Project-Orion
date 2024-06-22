extends Node2D

var plant_hint_timer = 0
var harvest_hint_timer = 0
var icons_list = [
[preload("res://Assets/Textures/Cabbage_result.png"), 'cabbage'],
[preload("res://Assets/Textures/Wheat_result.png"), 'carrot']#temp fix TODO make carrot texture and place it here
]
var icons_list_index:int
var current_seed_type:String

func plant_hint_on():
	$plant_hint.visible = true
	plant_hint_timer = 10

func harvest_hint_on():
	$harvest_hint.visible = true
	harvest_hint_timer = 10

func change_seed_type():
	if icons_list_index == len(icons_list)-1:
		icons_list_index = 0
	else:
		icons_list_index+=1
	current_seed_type = icons_list[icons_list_index][1]
	$seed_type.texture = icons_list[icons_list_index][0]

func _ready():
	change_seed_type()

func _process(delta):
	harvest_hint_timer-=1
	plant_hint_timer-=1
	if plant_hint_timer<=0:
		$plant_hint.visible = false
	if harvest_hint_timer<=0:
		$harvest_hint.visible = false
	
	if Input.is_action_just_pressed("change_seed_type"):
		change_seed_type()



	
