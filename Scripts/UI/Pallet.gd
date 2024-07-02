extends Control

@onready var icons = $'..'.icons

func update():
	var enumerate = 0
	for i in $"Inventory_slots".get_children():
		if BackgroundScene.inventory[enumerate]:
			i.texture = icons[BackgroundScene.inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
	enumerate = 0
	for i in $"Pallet_slots".get_children():
		if BackgroundScene.pallet_inventory[enumerate]:
			i.texture = icons[BackgroundScene.pallet_inventory[enumerate][0]]
			i.get_child(0).text = str(BackgroundScene.pallet_inventory[enumerate][1])
		else:
			i.texture = icons['transparent']
			i.get_child(0).text = ""
		enumerate += 1
			
func _ready():
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
