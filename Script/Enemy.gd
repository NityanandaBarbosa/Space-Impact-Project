extends Area2D

export var minSpeed: float = -300
export var maxSpeed: float = -100

export var life: int = 20

var speed: float = 0
var rotationRate: float = 0

var rng = RandomNumberGenerator.new()


func _ready():
	randomize()
	speed = rand_range(minSpeed,maxSpeed)
	
func _physics_process(delta):
	position.x  += speed * delta
	#position.y  += speed * delta

func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
