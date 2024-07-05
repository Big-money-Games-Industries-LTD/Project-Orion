extends Control


var money:int
var is_full: bool

func update():
	money = BackgroundScene.money
	is_full = BackgroundScene.pallet_inventory_amount(true)
	$Money.text = str(money)
	if int($Wheat_price/Label.text) > money or is_full:
		$Wheat_buy_button.disabled = true
		$Carrot_buy_button.disabled = true
		$Cabbage_buy_button.disabled = true
	elif int($Carrot_price/Label.text) > money:
		$Wheat_buy_button.disabled = false
		$Carrot_buy_button.disabled = true
		$Cabbage_buy_button.disabled = true
	elif int($Cabbage_price/Label.text) > money:
		$Wheat_buy_button.disabled = false
		$Carrot_buy_button.disabled = false
		$Cabbage_buy_button.disabled = true
	else:
		$Wheat_buy_button.disabled = false
		$Carrot_buy_button.disabled = false
		$Cabbage_buy_button.disabled = false

func _on_wheat_buy_button_pressed():
	BackgroundScene.add_to_inventory("wheat_seed", 1)
	BackgroundScene.money -= int($Wheat_price/Label.text)

func _on_carrot_buy_button_pressed():
	BackgroundScene.add_to_inventory("carrot_seed", 1)
	BackgroundScene.money -= int($Carrot_price/Label.text)

func _on_cabbage_buy_button_pressed():
	BackgroundScene.add_to_inventory("cabbage_seed", 1)
	BackgroundScene.money -= int($Cabbage_price/Label.text)
	
func _process(_delta):
	update()
