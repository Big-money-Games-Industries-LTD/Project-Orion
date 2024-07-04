extends Control


func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		$'..'.change_UI("Main_loader_UI")
