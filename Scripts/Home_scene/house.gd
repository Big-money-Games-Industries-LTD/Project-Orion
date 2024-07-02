extends Area2D


func _on_body_entered(body):
	if body is Player:
		BackgroundScene.day_skip()
