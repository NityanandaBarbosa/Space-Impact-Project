extends Node

var score : int = 0

func _ready():
	pass 

func _enemykilled(points):
	score += points
