extends Area2D

var speed: float = 100
var life: float = 100
var choice = 0
var random = RandomNumberGenerator.new()
var current_time = 0
const MOVIMENTATION_TIME = 100

func _ready():
	pass
	
func _physics_process(delta):
	current_time += 1
	print(current_time)
	if (current_time == MOVIMENTATION_TIME):
		current_time = 0
		print('ESCOLHI OUTRO LADO')
		choice = random.randi_range(0, 1)
		print(choice)
	if (choice == 1):
		print('baixo')
		position.y += speed * delta
	elif (choice == 0):
		print('cima')
		position.y -= speed * delta
