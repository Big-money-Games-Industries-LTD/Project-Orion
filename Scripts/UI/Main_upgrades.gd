extends Control


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
