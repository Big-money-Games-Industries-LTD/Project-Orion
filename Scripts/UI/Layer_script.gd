extends Control

@onready var self_layer = int(name.right(1))

func button_pressed():
	BackgroundScene.aqueducts_in_fields[self_layer-1] += 1


func _ready():
	pass

func _process(delta):
	var aqueducts_existing = BackgroundScene.aqueducts_in_fields[self_layer-1]
	for i in range(aqueducts_existing,0,-1):
		get_node('Slot_'+str(self_layer)+'_'+str(i)+'/Build_button').disabled=true
		
