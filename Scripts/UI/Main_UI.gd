extends Control

@onready var icons = $"..".icons

func update():
	var enumerate = 0
	for i in $slots.get_children():
		if BackgroundScene.inventory[enumerate]:
			i.texture = icons[BackgroundScene.inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
		

func _ready():
	update()


func _process(_delta):
	$inventory.frame = BackgroundScene.inventory_pos
	update()
