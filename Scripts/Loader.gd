extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.get_child(0).loader_UI()

func _on_body_exited(body):
	if body is Player:
		body.get_child(0).main_UI()
