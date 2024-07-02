extends Control


func change_UI(_name):
	for i in get_children():
		if not i.name == _name:
			i.visible = false
		else:
			i.visible = true

func _ready():
	change_UI("Main_loader_UI")
