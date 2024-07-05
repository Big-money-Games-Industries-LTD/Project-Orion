extends Control

func update():
	$Weight/Label.text = str(BackgroundScene.pallet_inventory_amount())+'/10'
	$Profit/Label2.text = str(BackgroundScene.pallet_inventory_price())
	if BackgroundScene.pallet_inventory_amount() == 0 or BackgroundScene.pallet_inventory_price() == 0 or BackgroundScene.is_delivery_started:
		$Delivery_button.disabled = true
	else:
		$Delivery_button.disabled = false


func _process(_delta):
	update()
	

func _on_upgrades_button_pressed():
	$"..".change_UI('Upgrades_UI')


func _on_delivery_button_pressed():
	BackgroundScene.sell()
	BackgroundScene.was_the_scene_loaded_after_cutscene = true
	BackgroundScene.before_cutscene_position_saver = $"../..".get_pos()
	get_tree().change_scene_to_file("res://Scenes/Cutscenes/Delivery_cutscene.tscn")
	BackgroundScene.start_delivery()
