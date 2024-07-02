extends Control


func _ready():
	for slot in get_children():
		slot.gui_input.connect(_gui_input_.bind(slot))
		slot.get_child(0).set_mouse_filter(MOUSE_FILTER_IGNORE)
		
func _gui_input_(event, slot_):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if BackgroundScene.pallet_inventory[int(slot_.name.right(1))]:
				BackgroundScene.add_to_inventory(BackgroundScene.pallet_inventory[int(slot_.name.right(1))][0], BackgroundScene.pallet_inventory[int(slot_.name.right(1))][1])
				BackgroundScene.remove_from_pallet_inventory(int(slot_.name.right(1)), BackgroundScene.pallet_inventory[int(slot_.name.right(1))][1])
