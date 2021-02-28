extends HBoxContainer

var life_pre = preload("res://Scenes/Life.tscn")
var life_control = Global.life
var is_dead = false
var death_time

func _ready():
	for i in range(life_control):
		var life = life_pre.instance()
		add_child(life)

func _process(delta):
	var time = OS.get_system_time_secs()
	
	if(Global.life < life_control):
		for c in get_children():
			c.queue_free()
			life_control -= 1
	else:
		if(Global.life > life_control):
			var life = life_pre.instance()
			add_child(life)
			life_control += 1
	game_over(Global.life, time)

func game_over(life, time):
	if(life == 0 and is_dead == false):
		death_time = time
		is_dead = true
	elif(life <= 0 and is_dead == true):
		if(time - death_time == 1):
			Global._reset_values()
			get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
