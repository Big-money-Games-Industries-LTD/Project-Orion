extends Node2D

var scene_list = []
var frames:int

func node_list(node):
	scene_list.append(node)

func _enter_tree():
	get_tree().node_added.connect(self.node_list)


func _ready():
	get_tree().node_added.disconnect(self.node_list)#should be first string in _ready()
	#this one is to get a list of nodes in the scene
	
	var sprite #setting frames variable, so we know how many frames do we have
	for i in scene_list:
		if i is Sprite2D:
			sprite = i
			break
	frames = sprite.hframes


func _process(delta):
	pass
