#@tool
extends Node2D
var i = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if i:
		i-=1
		var a = $Bed0.duplicate()
		a.position.x = $Bed0.position.x + 40*i
		$".".add_child(a)
