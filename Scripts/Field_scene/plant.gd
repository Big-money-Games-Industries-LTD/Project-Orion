extends Node2D

var scene_list = []
var sprites = []
@onready var bed_pointer = $".".get_meta('bed_pointer')


func node_list(node):
	scene_list.append(node)

func _enter_tree():
	get_tree().node_added.connect(self.node_list)


func _ready():
	get_tree().node_added.disconnect(self.node_list)#should be first string in _ready()
	#this one is to get a list of nodes in the scene
	for i in scene_list:#getting all of our sprites
		if i is Sprite2D:
			sprites.append(i)
	


func _process(_delta):
	for i in sprites:
		i.frame = BackgroundScene.beds_list[bed_pointer[0]][bed_pointer[1]].frame
		
