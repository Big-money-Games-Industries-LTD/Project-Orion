extends Area2D

var action_enable
var player
var is_ui_active

func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()
		action_enable = true
		player = body
	
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
		is_ui_active = true
	if is_ui_active and Input.is_action_just_pressed("esc"):
		player.get_child(0).main_UI()
		#TODO: disable player movement
		
