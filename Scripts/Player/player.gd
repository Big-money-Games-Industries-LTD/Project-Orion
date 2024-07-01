class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -280.0
const ACCELERATION = 1
const RUN_INNERT = 10
const JUMP_INNERT = 8

var beds_i_touch = BackgroundScene.Set.new()
var scenes_list
var current_scene_index

signal PlayerTurn

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimatedSprite2D
	
func _ready():
	current_scene_index = BackgroundScene.current_scene_index
	%Ui.visible = true


func delayed_ready():
	if BackgroundScene.position_saver == 'left':
		position = $"..".border_left_get_position()
	elif BackgroundScene.position_saver == 'right':
		position = $"..".border_right_get_position()
	elif BackgroundScene.position_saver:
		position = BackgroundScene.position_saver
	BackgroundScene.position_saver = false
	scenes_list = BackgroundScene.scenes_list

func _process(delta):
	if not scenes_list:
		scenes_list = BackgroundScene.scenes_list
		print(scenes_list)
		current_scene_index = BackgroundScene.current_scene_index
	if Input.is_action_just_pressed("scene_change_down") and not( current_scene_index == 1 or current_scene_index == 0 or current_scene_index == len(scenes_list)-1):#scene changing script; we do ante-list_index_out_of_range check and then change scene
		%Camera2D.position_smoothing_enabled = false
		BackgroundScene.position_saver = position
		BackgroundScene.current_scene_index -= 1
		get_tree().change_scene_to_file(scenes_list[current_scene_index-1])
	if Input.is_action_just_pressed("scene_change_up") and not( current_scene_index == len(scenes_list)-2 or current_scene_index == 0 or current_scene_index == len(scenes_list)-1):
		%Camera2D.position_smoothing_enabled = false
		BackgroundScene.position_saver = position
		BackgroundScene.current_scene_index += 1
		get_tree().change_scene_to_file(scenes_list[current_scene_index+1])
