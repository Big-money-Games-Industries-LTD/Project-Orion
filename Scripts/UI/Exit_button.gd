extends Control

@export var path: String
@export var unlock_movement: bool
@export_node_path("Control") var parent_node
	

func _on_texture_button_pressed():
	if parent_node:
		get_node(parent_node).change_UI(path)
		if unlock_movement:
			BackgroundScene.is_movement_available = true
	else:
		$"..".change_scene(path)
		if unlock_movement:
			BackgroundScene.is_movement_available = true
