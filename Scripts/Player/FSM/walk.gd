#walk.gd
extends StatePlayer

func enter(_msg: Dictionary={}):
	pass

func inner_physics_process(delta):
	
	if not player.is_on_floor():
		state_machine.change_to("Air")
	
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction * player.SPEED, 0.5)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED/10)

	#if direction < 0 and not player.animation.is_flipped_h():
		#player.animation.set_flip_h(true)
		#player.PlayerTurn.emit("left")
	#elif direction > 0 and player.animation.is_flipped_h():
		#player.animation.set_flip_h(false)
		#player.PlayerTurn.emit("right")

	player.move_and_slide()
