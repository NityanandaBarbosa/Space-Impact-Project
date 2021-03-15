extends Area2D

var plBullet := preload("res://Scenes/Enemy Nave/enemyBullet.tscn")
var plLife := preload("res://Scenes/LifeToSpawn.tscn")

export var minSpeed: float = -100
export var maxSpeed: float = -300

export var life: int = 4
export var fireDelay: float = 4
var shotControl = false

var speed: float = 0
var speed_vertical: float = -150
var rotationRate: float = 0
var timer = false
onready var normalGun := $"FireGun"
onready var fireDelayTimer := $FireDelayerTimer

var rng = RandomNumberGenerator.new()

var MOVIMENTATION_TIME: int = 0
var current_time = 0
var choice = 0
var random_choice = 0

func _ready():
	randomize()
	speed = rand_range(minSpeed,maxSpeed)
	MOVIMENTATION_TIME = rand_range(20,80)
	
func _process(delta):
	if timer == false:
		if shotControl == true:
			$FireDelayTimer.wait_time = fireDelay
			$FireDelayTimer.start()
			var bulllet := plBullet.instance()
			bulllet.global_position = normalGun.global_position
			get_tree().current_scene.add_child(bulllet)
			timer = true
	
func _physics_process(delta):
	position.x  += speed * delta
	current_time += 1
	if (current_time == MOVIMENTATION_TIME):
		current_time = 0
		choice = rng.randi_range(0, 1)
	if (choice == 1):
		position.y += speed_vertical * delta
	elif (choice == 0):		
		position.y -= speed_vertical * delta
		
	var viewRect := get_viewport_rect()
	position.y = clamp(position.y,0, viewRect.size.y)

func damage(amount: int):
	life -= amount
	if life <= 0:
		random_life()
		queue_free()
		Global._enemykilled(3)
		

func random_life():
	rng.randomize()
	random_choice = rng.randi_range(0, 2)
	if random_choice == 1:
		var life_scores := plLife.instance()
		life_scores.global_position = $".".global_position
		get_tree().current_scene.add_child(life_scores)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_FireDelayTimer_timeout():
	if timer == true:
		timer = false


func _on_Enemy_area_entered(area):
	var c = 0
	if area.is_in_group("player"):
		Global._decrease_life()
		queue_free()
		Global._explosion(true)

	else:
		if area.is_in_group("GameScreen"):
			#print("To dentro")
			shotControl = true
