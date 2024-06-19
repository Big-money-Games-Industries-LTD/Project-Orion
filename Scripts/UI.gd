extends Node2D

var plant_hint_timer = 0
var harvest_hint_timer = 0

func plant_hint_on():
	$plant_hint.visible = true
	plant_hint_timer = 10

func harvest_hint_on():
	$harvest_hint.visible = true
	harvest_hint_timer = 10

func _ready():
	pass

func _process(delta):
	harvest_hint_timer-=1
	plant_hint_timer-=1
	if plant_hint_timer<=0:
		$plant_hint.visible = false
	if harvest_hint_timer<=0:
		$harvest_hint.visible = false



	
