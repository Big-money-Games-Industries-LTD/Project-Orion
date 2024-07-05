extends Control

@export var path: String
@export_node_path("Control") var parent_node
	

func _on_texture_button_pressed():
	if parent_node:
		parent_node.change_scene(path)
	else:
		$"..".change_scene(path)
