extends Area2D

var action_enable
var player
var UI
var is_ui_active

func _on_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()
		action_enable = true
		player = body
		UI = body.get_child(3)
	
func _on_body_exited(body):
	if body is Player:
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D.stop()
		action_enable = false
		player = null
		UI.change_UI('Main_UI')

func _process(_delta):
	if action_enable and Input.is_action_just_pressed("action0"):
		UI.change_UI('Pallet_UI')
		is_ui_active = true
		BackgroundScene.is_movement_available = false
	if is_ui_active and Input.is_action_just_pressed("esc"):
		UI.change_UI('Main_UI')
		BackgroundScene.is_movement_available = true
		
