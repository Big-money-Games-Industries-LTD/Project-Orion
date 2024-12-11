extends Node2D

		
func _on_border_right_body_entered(body):
	if body is Player:
		BackgroundScene.current_scene_index = BackgroundScene.scene_saver
		get_tree().change_scene_to_file(BackgroundScene.scenes_list[BackgroundScene.current_scene_index])
		BackgroundScene.position_saver = 'right'
		
func _ready():
	$Seller.play("default")
