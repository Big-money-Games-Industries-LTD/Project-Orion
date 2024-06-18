# camera_position.gd
extends Marker2D

@onready var player = owner as Player


# Called when the node enters the scene tree for the first time.
#func _ready():
#	player.PlayerTurn.connect(_on_player_u_turn)
#	position.x = 30


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_player_u_turn(anim_direction):
	#print("Player is turn to %s " % anim_direction)
#	match anim_direction:
#		"right":
#			position.x = 30
#		"left":
#			position.x = -30
