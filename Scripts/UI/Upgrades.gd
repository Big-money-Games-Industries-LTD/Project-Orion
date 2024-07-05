extends Control


func change_UI(_name):
	for i in get_children():
		if not i.name == _name:
			i.visible = false
		else:
			i.visible = true
			
			
func _draw():
	change_UI("Main_upgrades")
	
	
func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		$'..'.change_UI("Main_loader_UI")
