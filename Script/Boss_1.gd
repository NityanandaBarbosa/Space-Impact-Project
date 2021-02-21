extends Area2D

signal boss_killed

var show_boss = false
var speed: float = 100
var life: float = 100
var choice = 0
var random = RandomNumberGenerator.new()
var current_time = 0
const MOVIMENTATION_TIME = 100

func _ready():
	$".".visible = false
	
func _physics_process(delta):
	if (show_boss):
		process_boss(delta)
	
func process_boss(delta):
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
		emit_signal("boss_killed")

func _on_GameScreen_boss_fight_start(phase_number):
	if (phase_number == 0):
		show_boss = true
		$".".visible = true
