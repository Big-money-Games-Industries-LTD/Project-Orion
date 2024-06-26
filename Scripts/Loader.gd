extends Area2D


func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()
		body.get_child(0).loader_UI()

func _on_body_exited(body):
	if body is Player:
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D.stop()
		body.get_child(0).main_UI()
