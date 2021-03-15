extends Area2D

signal boss_killed(phase)

var show_boss = false
var speed: float = 200
var life: float = 120
var full_life = life
onready var lifeProgress := $"Control/LifeProgress"
var timer = false
export var fireDelay: float = 0.3
onready var normalGun := $"FireGun"
var plBullet := preload("res://Scenes/Boss_1/Boss_2_Bullet.tscn")
var choice = 0
var random = RandomNumberGenerator.new()
var current_time = 0
const MOVIMENTATION_TIME = 100
const phase = 1

func _ready():
	$".".visible = false

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
	if (show_boss):
		process_boss(delta)
	
func process_boss(delta):
	# print("2: ", life)
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
		
func _on_FireDelayerTimer_timeout():
	if timer == true:
		timer = false
		
func damage(amount: int):
	if($".".is_visible_in_tree()):
		life -= amount
		lifeProgress.value = life/full_life*100
		if life <= 0:
			queue_free()
			Global._enemykilled(15)
			emit_signal("boss_killed", phase)

func _on_GameScreen_boss_fight_start(phase_number):
	if (phase_number == 1):
		show_boss = true
		$".".visible = true


func _on_Boss_2_area_shape_entered(area_id, area, area_shape, self_shape):
	if($".".is_visible_in_tree()):
		if area.is_in_group("player"):
			Global._decrease_life()
