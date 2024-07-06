extends Control

var upgrades = {
	'fading_probability':{
		'max_value': 0.1,
		'min_value': 0,
		'step': 0.01,
		'price': 99
	},
	'harvest_probability':{
		'max_value': 0.5,
		'min_value': 0,
		'step': 0.1,
		'price': 98
	},
	'multiplier':{
		'max_value': 2,
		'min_value': 1,
		'step': 0.2,
		'price': 97
	},
	'harvesting_time':{
		'max_value': 0.4,
		'min_value': 2,
		'step': 0.2,
		'price': 96
	},
	'delivery_time':{
		'max_value': BackgroundScene.delivery_duration*2,
		'min_value': BackgroundScene.seconds_to_ticks(20),
		'step': BackgroundScene.seconds_to_ticks(88),
		'price': 95
	},
	'prices_multiplier':{
		'max_value': 2,
		'min_value': 1,
		'step': 0.1,
		'price': 94
	}
}

func _on_to_aqueducts_button_pressed():
	$"..".change_UI("Aqueducts_upgrades")

func _on_fade_prob_button_pressed():#TODO:add money check(for all buttons), maybe add a unified checking function in main_upgrades
	if BackgroundScene.fading_probability != 0:
		BackgroundScene.fading_probability -= 0.01
	else:
		pass#TODO: notify him about it(for all buttons)

func _on_harvest_prob_button_pressed():
	if BackgroundScene.increased_harvest_probability != 0.5:
		BackgroundScene.increased_harvest_probability += 0.1
	else:
		pass

func _on_growth_time_button_pressed():
	if BackgroundScene.multiplier != 0.5:
		BackgroundScene.multiplier += 0.1
	else:
		pass

func _on_delivery_time_button_pressed():
	if BackgroundScene.delivery_duration != BackgroundScene.seconds_to_ticks(20):
		BackgroundScene.delivery_duration -= BackgroundScene.seconds_to_ticks(88)
		if BackgroundScene.delivery_duration < BackgroundScene.seconds_to_ticks(20):
			BackgroundScene.delivery_duration = BackgroundScene.seconds_to_ticks(20)
	else:
		pass
