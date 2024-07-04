extends Control

func update():
	$Weight/Label.text = str(BackgroundScene.pallet_inventory_amount())+'/10'
	$Profit/Label2.text = str('TODO') #TODO: prices table


func _process(_delta):
	update()
	

func _on_upgrades_button_pressed():
	$"..".change_UI('Upgrades_UI')


func _on_delivery_button_pressed():
	print('delivery has been started')
