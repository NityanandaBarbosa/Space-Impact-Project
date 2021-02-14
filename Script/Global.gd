extends Node

var score : int = 0

func _ready():
	pass # Replace with function body.

func _enemykilled(points):
	score += points
