extends StatePlayer

func inner_physics_process(delta):
	player.velocity.y += player.gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction * player.SPEED, player.ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.JUMP_INNERT)
	
	player.move_and_slide()

	if player.is_on_floor():
		if player.velocity.x == 0:
			state_machine.change_to("Idle")
		else:
			state_machine.change_to("Walk")
