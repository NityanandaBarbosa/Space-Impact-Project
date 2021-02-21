extends Area2D

var plBullet := preload("res://Scenes/Enemy Nave/enemyBullet.tscn")

export var minSpeed: float = -300
export var maxSpeed: float = -100
export var life: int = 20
export var fireDelay: float = 1.2
var shotControl = false

var speed: float = 0
var rotationRate: float = 0
var timer = false
onready var normalGun := $"FireGun"
onready var fireDelayTimer := $FireDelayerTimer

var rng = RandomNumberGenerator.new()


func _ready():
	randomize()
	speed = rand_range(minSpeed,maxSpeed)
	
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

func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()
		Global._enemykilled(3)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_FireDelayTimer_timeout():
	if timer == true:
		timer = false


func _on_Enemy_area_entered(area):
	if area.is_in_group("player"):
		Global.life -= 1
		queue_free()
	else:
		if area.is_in_group("GameScreen"):
			print("To dentro")
			shotControl = true
