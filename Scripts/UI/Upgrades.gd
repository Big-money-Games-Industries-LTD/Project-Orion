extends Control


func change_UI(name_):
	for i in get_children():
		if not i.name == name_:
			i.hide()
		else:
			i.show()


func _draw():
	change_UI("Page_1")
	

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		$'..'.change_UI("Main_loader_UI")
