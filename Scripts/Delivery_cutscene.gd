extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pallet2.frame = BackgroundScene.pallet_inventory_amount()
	$Loader.play("default")
	$AnimationPlayer.play("Delivery")
	

func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Scenes/Load.tscn")
