extends Area2D

export var minSpeed: float = -50
export var maxSpeed: float = -10
export var minRotationRate: float = -40
export var maxRotationRate: float = 40

var speed: float = 0
var rotationRate: float = 0

func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.x  += speed * delta
	position.y  += speed * delta
