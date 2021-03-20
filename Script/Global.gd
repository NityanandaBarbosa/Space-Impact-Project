extends Node

var score : int = 0
var control_shot = false
var control_sound = true
var control_explosion = false
export var life: int = 3
var highScore = 0

func _ready():
	pass 

func _enemykilled(points):
	score += points

func _explosion(state):
	control_explosion = state

func _check_high_score():
	if(score > highScore):
		highScore = score

func _reset_values():
	_check_high_score()
	life = 3
	score = 0
	
func _increase_life ():
	if(life <= 2):
		life += 1

func _decrease_life():
	if(life >= 1):
		life -= 1
