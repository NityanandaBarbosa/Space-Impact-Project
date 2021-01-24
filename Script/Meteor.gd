extends Area2D

export var minSpeed: float = -100
export var maxSpeed: float = 100
export var minRotationRate: float = -75
export var maxRotationRate: float = 75


var speed: float = 0
var rotationRate: float = 0

var rng = RandomNumberGenerator.new()


func _ready():
	randomize()
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.x  += speed * delta
	position.y  += speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
