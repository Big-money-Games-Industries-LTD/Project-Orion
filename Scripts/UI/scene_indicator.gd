extends RichTextLabel

var scenes_table = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 0
	while true:
		if i == 0:
			scenes_table[0] = 'Load scene'
		elif i == len(BackgroundScene.scenes_list)-1:
			scenes_table[i] = 'Home scene'
			break
		else:
			scenes_table[i] = 'Layer '+str(i)
		i+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = scenes_table[BackgroundScene.current_scene_index]
