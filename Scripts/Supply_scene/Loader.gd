extends Area2D

var action_enable
var player
var UI


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
		
		
func _ready():
	$Loader.play("default")
func _process(_delta):
	if action_enable and Input.is_action_just_pressed("action0"):
		UI.change_UI('Loader_UI')
		BackgroundScene.is_movement_available = false
