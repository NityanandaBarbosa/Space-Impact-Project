extends Node2D

var current_phase = null # 0 - phase 1; 1 - phase 2; 2 - phase 3
var phase_start_time = null
var current_time_passed = 0

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
const PHASE_TIME = [30, 60, 90]

var rng = RandomNumberGenerator.new()

func _ready():
	
	start_phase(0)
	rng.randomize()
	
	var NumberOfMeteros = rng.randf_range(20, 40)
	
	for i in range(NumberOfMeteros):
		
		
		randomize()
		var x = randi() % packed_scene.size() 
		
		location.x = rand_range(1,window_size.x)
		location.y = rand_range(1,window_size.y)
		
		var scene =  packed_scene[x].instance()
		scene.position = location
	
		
		add_child(scene)

func _process(delta):
	process_frame()
	
	
	
	#onready var fireDelayTimer := $FireDelayerTimer
	
	
	
func start_phase(phase_number):
	current_phase = phase_number
	$background.texture = load(PHASE_BACKGROUND[current_phase])
	phase_start_time = OS.get_system_time_secs()

func process_frame():
	current_time_passed = OS.get_system_time_secs() - phase_start_time
	if (current_time_passed >= PHASE_TIME[current_phase]):
		start_phase(current_phase + 1)
