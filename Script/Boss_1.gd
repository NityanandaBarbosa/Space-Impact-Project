extends Area2D


var speed: float = 100
var life: float = 100
var timer = false
export var fireDelay: float = 0.3
onready var normalGun := $"FireGun"
var plBullet := preload("res://Scenes/Boss_1/Boss_1_Bullet.tscn")
var choice = 0
var random = RandomNumberGenerator.new()
var current_time = 0
const MOVIMENTATION_TIME = 100

func _ready():
	pass

func _process(delta):
	if $".".is_visible_in_tree() == true:
		if timer == false:
			$FireDelayerTimer.wait_time = fireDelay
			$FireDelayerTimer.start()
			var bulllet := plBullet.instance()
			bulllet.global_position = normalGun.global_position
			get_tree().current_scene.add_child(bulllet)
			timer = true
	
func _physics_process(delta):
	current_time += 1
	print(current_time)
	if (current_time == MOVIMENTATION_TIME):
		current_time = 0
		choice = random.randi_range(0, 1)
		#print('ESCOLHI OUTRO LADO')
		#print(choice)
	if (choice == 1):
		position.y += speed * delta
		#print('baixo')
	elif (choice == 0):		
		position.y -= speed * delta
		#print('cima')
		
func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()
		Global._enemykilled(15)


func _on_FireDelayerTimer_timeout():
	if timer == true:
		timer = false
