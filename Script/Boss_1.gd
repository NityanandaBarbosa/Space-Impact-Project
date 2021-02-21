extends Area2D


signal boss_killed(phase)

var show_boss = false
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
const phase = 0

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
	$".".visible = false
	
func _physics_process(delta):
	if (show_boss):
		process_boss(delta)
	
func process_boss(delta):
	# print("1: ", life)
	current_time += 1
	# sprint(current_time)
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
	if (phase_number == 0):
		show_boss = true
		$".".visible = true


func _on_FireDelayerTimer_timeout():
	if timer == true:
		timer = false
