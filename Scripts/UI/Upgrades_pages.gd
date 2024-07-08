extends Control

@onready var current_page:int = int(name.right(1))

var upgrades = {
	'fading_probability':{
		'max_value': 0,
		'min_value': 0.1,
		'step': 0.01,
		'price': 99,
		'var': BackgroundScene.fading_probability
	},
	'harvest_probability':{
		'max_value': 0.5,
		'min_value': 0,
		'step': 0.1,
		'price': 98,
		'var': BackgroundScene.increased_harvest_probability
	},
	'multiplier':{
		'max_value': 2,
		'min_value': 1,
		'step': 0.2,
		'price': 97,
		'var': BackgroundScene.multiplier
	},
	'harvesting_time':{
		'max_value': 0.4,
		'min_value': 2,
		'step': 0.2,
		'price': 96,
		'var': BackgroundScene.harvesting_time
	},
	'delivery_time':{
		'max_value': BackgroundScene.delivery_duration*2,
		'min_value': BackgroundScene.seconds_to_ticks(20),
		'step': BackgroundScene.seconds_to_ticks(88),
		'price': 95,
		'var': BackgroundScene.delivery_duration
	},
	'prices_multiplier':{
		'max_value': 2,
		'min_value': 1,
		'step': 0.1,
		'price': 94,
		'var': false #TODO: ADD VAR
	}
}

func update():
	if name != "Page_3":
		for i in $Buttons.get_children():
			if not upgrades[i.name.to_lower()]['var'] is bool:
#				print(i.name.to_lower())
#				print(upgrades[i.name.to_lower()]['var'])
#				print(i.disabled)
				if upgrades[i.name.to_lower()]['max_value'] == float(get_node('Current/'+ i.name +'/Label').text):
					print(upgrades[i.name.to_lower()]['max_value'])
					print(get_node('Current/'+ i.name +'/Label').text)
					i.disabled = true
				else:
					i.disabled = false
		for i in $Prices.get_children():
			i.get_child(0).text = str(upgrades[i.name.to_lower()]['price'])
		for i in $Current.get_children():
			upgrades[i.name.to_lower()]['var'] = BackgroundScene.Iupgrades_pages(i.name.to_lower())#FIXME: not effective because someone else changes var, we need to fix it
#			if(i.name.to_lower()) == 'fading_probability':
#			print(upgrades[i.name.to_lower()]['var'])
			i.get_child(0).text = str(upgrades[i.name.to_lower()]['var'])
		

func _on_fade_prob_button_pressed():#TODO:add money check(for all buttons), maybe add a unified checking function in main_upgrades
	BackgroundScene.fading_probability -= 0.01

func _on_harvest_prob_button_pressed():
	BackgroundScene.increased_harvest_probability += 0.1

func _on_multiplier_pressed():
	BackgroundScene.multiplier += 0.1

func _on_delivery_time_button_pressed():
	BackgroundScene.delivery_duration -= BackgroundScene.seconds_to_ticks(88)
	if BackgroundScene.delivery_duration < BackgroundScene.seconds_to_ticks(20):
		BackgroundScene.delivery_duration = BackgroundScene.seconds_to_ticks(20)


func _on_harvesting_time_button_pressed():
	BackgroundScene.harvesting_time-=upgrades['harvesting_time']['step']


func _on_prices_multiplier_button_pressed():
	pass # Replace with function body.
	
func _on_to_left_pressed():
	$"..".change_UI("Page_" + str(current_page - 1))

func _on_to_right_pressed():
	$"..".change_UI("Page_" + str(current_page + 1))

func _process(_delta):
	update()
#	print(upgrades['fading_probability']['max_value'])
#	print(upgrades['fading_probability']['var'])
#	print(BackgroundScene.fading_probability)
#	print()
