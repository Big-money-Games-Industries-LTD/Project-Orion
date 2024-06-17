extends Node2D

var self_pointer

func _on_area_2d_body_entered(body):
	if body is Player:
		pass

func _process(delta):
	pass

func _ready():
	pass 

func delayed_ready():
	self_pointer = [$"..".self_index,self.name.right(1)]
