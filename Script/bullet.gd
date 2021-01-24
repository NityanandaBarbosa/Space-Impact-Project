extends Area2D

export var speed: float = 40

func _physics_process(delta):
	position.x += speed + delta
	
