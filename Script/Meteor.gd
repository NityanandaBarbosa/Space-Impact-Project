extends Area2D

export var minSpeed: float = -300
export var maxSpeed: float = -100
export var minRotationRate: float = -255
export var maxRotationRate: float = 255

export var life: int = 20

var speed: float = 0
var rotationRate: float = 0

signal score

var rng = RandomNumberGenerator.new()


func _ready():
	randomize()
	speed = rand_range(minSpeed,maxSpeed)
	rotationRate = rand_range(minRotationRate,maxRotationRate)
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.x  += speed * delta
	#position.y  += speed * delta

func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()
		Global._enemykilled(2)
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
