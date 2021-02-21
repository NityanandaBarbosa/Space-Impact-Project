extends Node

var score : int = 0
export var life: int = 3

func _ready():
	pass 

func _enemykilled(points):
	score += points
