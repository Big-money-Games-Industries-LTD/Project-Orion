extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_border_left_body_entered(body):
	if body is Player:
		BackgroundScene.current_scene_index = BackgroundScene.scene_saver
		get_tree().change_scene_to_file(BackgroundScene.scenes_list[BackgroundScene.current_scene_index])
		BackgroundScene.position_saver = 'left'
