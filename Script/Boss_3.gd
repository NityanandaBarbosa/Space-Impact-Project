extends Area2D

signal boss_killed(phase)

var show_boss = false
var speed: float = 100
var life: float = 100
var choice = 0
var random = RandomNumberGenerator.new()
var current_time = 0
const MOVIMENTATION_TIME = 100
const phase = 2

onready var gunsPositions := $gunsPosition
onready var gun1:= $"gunsPosition/DownGun"
onready var gun2:= $"gunsPosition/UpGun"
var timer = false
export var fireDelay: float = 0.3
var plBullet := preload("res://Scenes/Boss_1/Boss_3_Bullet.tscn")

func _ready():
	$".".visible = false
	
func _process(delta):
	if $".".is_visible_in_tree() == true:
		if timer == false:
			$FireDelayerTimer.wait_time = fireDelay
			$FireDelayerTimer.start()
			for child in gunsPositions.get_children():
					var bulllet := plBullet.instance()
					bulllet.global_position = child.global_position
					get_tree().current_scene.add_child(bulllet)
			timer = true
	
func _physics_process(delta):
	if (show_boss):
		process_boss(delta)
	
func process_boss(delta):
	# print("3: ", life)
	current_time += 1
	# print(current_time)
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
	
	var viewRect := get_viewport_rect()
	position.y = clamp(position.y,0, viewRect.size.y)
		
func damage(amount: int):
	if($".".is_visible_in_tree()):
		life -= amount
		if life <= 0:
			queue_free()
			Global._enemykilled(15)
			emit_signal("boss_killed", phase)

func _on_GameScreen_boss_fight_start(phase_number):
	if (phase_number == 2):
		show_boss = true
		$".".visible = true


func _on_FireDelayerTimer_timeout():
	if timer == true:
		timer = false

