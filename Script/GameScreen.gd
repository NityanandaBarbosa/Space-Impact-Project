extends Node2D

var ms = 0
var s = 0
var m = 0

signal boss_fight_start(phase_number)
signal boss_fight_ends(phase_number)
signal phase_change(phase_number)

var bossMessage: float = 0 
var current_phase: float
var phase_start_time = null
var current_time_passed: float = 0
var boss_fight = false
const  window_size = Vector2(5000,720) #ajustar
var location = Vector2()
var packed_scene = [
	preload('res://Scenes/Meteor/Meteor.tscn'),
	preload('res://Scenes/Enemy Nave/Enemy.tscn')
]

const PHASE_BACKGROUND = [
	"res://Assests/Background/backgroud-phase-1.png", 
	"res://Assests/Background/backgroud-phase-2.png", 
	"res://Assests/Background/backgroud-phase-3.png"
]
const PHASE_TIME = [10, 10, 10]

var rng = RandomNumberGenerator.new()



func _ready():
	
	start_phase(0)
	rng.randomize()
	
	var NumberOfMeteros = rng.randf_range(20, 30)
	
	for i in range(NumberOfMeteros):
		
		
		randomize()
		var x = randi() % packed_scene.size() 
		
		location.x = rand_range(1240,window_size.x)
		location.y = rand_range(1,window_size.y)
		
		var scene =  packed_scene[x].instance()
		scene.position = location
	
		
		add_child(scene)

func _process(delta):
	
	
	#print(s)
	process_frame()
	
	pass
	
	
func _on_ms_timeout():
		ms += 1
	
	
	
	
	
	#onready var fireDelayTimer := $FireDelayerTimer
	
	
	
func start_phase(phase_number):
	if (phase_number <= 2):
		current_phase = phase_number
		$background.texture = load(PHASE_BACKGROUND[current_phase])
		phase_start_time = OS.get_system_time_secs()

func process_frame():
	current_time_passed = OS.get_system_time_secs() - phase_start_time
	if(current_time_passed < 6):
		$initMessage.show()
	else:
		$initMessage.hide()
	if((current_time_passed/PHASE_TIME[current_phase]) >= 0.7 and (current_time_passed/PHASE_TIME[current_phase]) <= 0.9):
		$bossMessage.show()
	else:
		$bossMessage.hide()
	if (current_time_passed >= PHASE_TIME[current_phase]):
		if(!boss_fight):
			spawn_boss(current_phase)

func spawn_boss(phase_number):
	emit_signal("boss_fight_start", phase_number)
	boss_fight = true

func _on_Boss_boss_killed(phase):
	start_phase(phase + 1)
	boss_fight = false
