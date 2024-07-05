extends Area2D


func _on_body_entered(body):
	if body is Player:
		BackgroundScene.day_skip()
		body.get_blackout_animation().play('default')
		BackgroundScene.is_movement_available = false
