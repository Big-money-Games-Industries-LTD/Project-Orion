#walk.gd
extends StatePlayer

var is_movement_available
var is_first_step = true

func enter(_msg: Dictionary={}): #HACK: Delete or complete
	pass

func inner_physics_process(_delta):
	is_movement_available = BackgroundScene.is_movement_available
	if not player.is_on_floor():
		state_machine.change_to("Air")
	
	
	var direction = Input.get_axis("left", "right")
	if direction and is_movement_available:
		if is_first_step:
			is_first_step = false
			%Camera2D.position_smoothing_enabled = true
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
