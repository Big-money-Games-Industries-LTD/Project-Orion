extends Area2D

var action_enable
var player

func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()
		action_enable = true
		player = body
		body.get_child(0).pallet_UI()
	
func _on_body_exited(body):
	if body is Player:
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D.stop()
		action_enable = false
		player = null
		body.get_child(0).main_UI()

func _process(_delta):
	if action_enable and Input.is_action_just_pressed("action0"):
		player.get_child(0).pallet_UI()
		#TODO: disable player movement
		
