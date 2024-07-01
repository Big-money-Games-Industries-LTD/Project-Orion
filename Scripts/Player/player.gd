class_name Player
extends CharacterBody2D
#TODO: a var in background scene or here to disable player movement

const SPEED = 300.0
const JUMP_VELOCITY = -280.0
const ACCELERATION = 1
const RUN_INNERT = 10
const JUMP_INNERT = 8

var beds_i_touch = BackgroundScene.Set.new()
var scenes_list
var current_scene_index

signal PlayerTurn

## Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = $AnimatedSprite2D

func _ready():
	if BackgroundScene.position_saver:
		position = BackgroundScene.position_saver
	current_scene_index = BackgroundScene.current_scene_index
	%Ui.visible = true


func delayed_ready():
	scenes_list = BackgroundScene.scenes_list

func _process(delta):
	if not scenes_list:
		scenes_list = BackgroundScene.scenes_list
		print(scenes_list)
		current_scene_index = BackgroundScene.current_scene_index
	if Input.is_action_just_pressed("scene_change_down") and not( current_scene_index == 1 or current_scene_index == 0 or current_scene_index == len(scenes_list)-1):#scene changing script; we do ante-list_index_out_of_range check and then change scene
		
		BackgroundScene.position_saver = position
		BackgroundScene.current_scene_index -= 1
		var scene = load(scenes_list[current_scene_index-1])
		get_tree().change_scene_to_file(scenes_list[current_scene_index-1])
	if Input.is_action_just_pressed("scene_change_up") and not( current_scene_index == len(scenes_list)-2 or current_scene_index == 0 or current_scene_index == len(scenes_list)-1):#
		
		BackgroundScene.position_saver = position
		BackgroundScene.current_scene_index += 1
		get_tree().change_scene_to_file(scenes_list[current_scene_index+1])

#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	
