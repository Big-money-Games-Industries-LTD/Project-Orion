extends StatePlayer


func enter(msg: Dictionary={}): #HACK: Delete or comlete
	pass


func inner_physics_process(delta):

	#if player.velocity.y < 0:
		#player.animation.play("jump")
	#elif player.velocity.y == 0:
		#player.animation.play("jumptofall")
	#else:
		#player.animation.play("fall")
	
	player.velocity.y += player.gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction * player.SPEED, player.ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.JUMP_INNERT)

	#if direction < 0:
		#player.animation.set_flip_h(true)
	#elif direction > 0:
		#player.animation.set_flip_h(false)
	
	player.move_and_slide()

	if player.is_on_floor():
		if player.velocity.x == 0:
			state_machine.change_to("Idle")
		else:
			state_machine.change_to("Walk")
