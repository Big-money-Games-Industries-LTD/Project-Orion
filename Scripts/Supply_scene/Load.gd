extends Node2D

func _ready():
	if BackgroundScene.was_the_scene_loaded_after_cutscene:
		$Player.position = BackgroundScene.before_cutscene_position_saver
		BackgroundScene.was_the_scene_loaded_after_cutscene = false

func _on_border_left_body_entered(body):
	if body is Player:
		BackgroundScene.current_scene_index = BackgroundScene.scene_saver
		get_tree().change_scene_to_file(BackgroundScene.scenes_list[BackgroundScene.current_scene_index])
		BackgroundScene.position_saver = 'left'
