extends Area2D

var plLife := preload("res://Scenes/LifeToSpawn.tscn")

export var minSpeed: float = -200
export var maxSpeed: float = -150
export var minRotationRate: float = -255
export var maxRotationRate: float = 255

export var life: int = 7

var speed: float = 0
var rotationRate: float = 0
var random_choice = 0

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
		random_life()
		queue_free()
		Global._enemykilled(2)
		
func random_life():
	rng.randomize()
	random_choice = rng.randi_range(0, 2)
	if random_choice == 1:
		var life_scores := plLife.instance()
		life_scores.global_position = $".".global_position
		get_tree().current_scene.add_child(life_scores)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Meteor_area_entered(area):
	if area.is_in_group("player"):
		Global._decrease_life()
		queue_free()
		Global._explosion(true)
