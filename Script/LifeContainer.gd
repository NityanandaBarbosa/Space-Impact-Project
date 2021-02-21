extends HBoxContainer

var life_pre = preload("res://Scenes/Life.tscn")
var life_control = Global.life

func _ready():
	for i in range(life_control):
		var life = life_pre.instance()
		add_child(life)

func _process(delta):
	if(Global.life < life_control):
		for c in get_children():
			c.queue_free()
			life_control -= 1
	else:
		if(Global.life > life_control):
			var life = life_pre.instance()
			add_child(life)
			life_control += 1
