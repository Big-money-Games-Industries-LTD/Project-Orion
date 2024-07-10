extends Area2D

var UI
var player
var is_action_avalible

func _on_body_entered(body):
	if body is Player:
		player = body
		UI = player.get_child(3)
		is_action_avalible = true
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("default")
		
func _on_body_exited(body):
	if body is Player:
		is_action_avalible = false
		$AnimatedSprite2D.hide()
		$AnimatedSprite2D.stop()

func _process(_delta):
	if is_action_avalible and Input.is_action_just_pressed("action0"):
		BackgroundScene.day_skip()
		player.get_blackout_animation().play('default')
		BackgroundScene.is_movement_available = false
