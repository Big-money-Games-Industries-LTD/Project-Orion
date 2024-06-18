extends Node2D

var hint_timer = 0


func _ready():
	pass



func _process(delta):
	hint_timer-=1
	if hint_timer<=0:
		$RichTextLabel.visible = false



func plant_hint_on():
	$RichTextLabel.visible = true
	hint_timer = 10
	
