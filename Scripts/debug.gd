extends Control


@export var enable: bool = false
var names = []
var values = []

func update(param_name, param_value):
	if param_name in names:
		values[names.find('param_name')] = param_value


func get_text():
	pass
#%Label.text += '\n[color=red][b]{text}[/b][/color]'.format(param_name, "{text}")
