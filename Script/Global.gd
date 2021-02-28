extends Node

var score : int = 0
var control_shot = false
export var life: int = 3

func _ready():
	pass 

func _enemykilled(points):
	score += points

func _reset_values():
	control_shot = false
	life = 3
