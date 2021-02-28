extends Node

var score : int = 0
var control_shot = false
export var life: int = 3
var highScore = 0

func _ready():
	pass 

func _enemykilled(points):
	score += points

func _check_high_score():
	if(score > highScore):
		highScore = score

func _reset_values():
	_check_high_score()
	life = 3
	score = 0
