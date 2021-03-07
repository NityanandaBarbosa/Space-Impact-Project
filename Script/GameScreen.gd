extends Node2D

var ms = 0
var s = 0
var m = 0

signal boss_fight_start(phase_number)
signal boss_fight_ends(phase_number)
signal phase_change(phase_number)

var bossMessage: float = 0 
var current_phase: float = 0
var phase_start_time = null
var current_time_passed: float = 0
var spawn_control: float = 0
var boss_fight = false
var init_phase = false
const  window_size = Vector2(5000,720) #ajustar
var location = Vector2()
var packed_scene = [
	preload('res://Scenes/Meteor/Meteor.tscn'),
	preload('res://Scenes/Enemy Nave/Enemy.tscn')
]

const PHASE_MUSIC = [
	preload("res://Assests/SoundEffects/bgm/Music_1.wav"),
	preload("res://Assests/SoundEffects/bgm/Music_2.wav"),
	preload("res://Assests/SoundEffects/bgm/Music_3.wav"),
	preload("res://Assests/SoundEffects/bgm/Music_Boss.wav")
]

const BEGINS_SENTENCES = ["The Phase One Will Begins", "The Phase Two Will Begins", "The Phase Three Will Begins"]

const PHASE_BACKGROUND = [
	"res://Assests/Background/backgroud-phase-1.png", 
	"res://Assests/Background/backgroud-phase-2.png", 
	"res://Assests/Background/backgroud-phase-3.png"
]
const PHASE_TIME = [15, 5, 5]

var rng = RandomNumberGenerator.new()

func _ready():
	
	start_phase(0)

func _process(delta):
	
	#print(s)
	process_frame()
	
	
func _on_ms_timeout():
		ms += 1
		
	#onready var fireDelayTimer := $FireDelayerTimer
	
func start_phase(phase_number):
	if (phase_number <= 2 ):
		spawn_control = 0
		Global.control_shot = false
		current_phase = phase_number
		$background.texture = load(PHASE_BACKGROUND[current_phase])
		phase_start_time = OS.get_system_time_secs()

func process_frame():
	phase_actions()

func spawn_boss(phase_number):
	if (current_time_passed >= PHASE_TIME[current_phase]):
		if(!boss_fight):
			$Music_Fase.set_stream(PHASE_MUSIC[3])
			$Music_Fase.play()
			emit_signal("boss_fight_start", phase_number)
			boss_fight = true
			var enemies = get_tree().get_nodes_in_group("damageable")
			for enemy in enemies:
				enemy.queue_free()
	
func spawn_enemys():
	
	rng.randomize()
	
	var NumberOfMeteros = rng.randf_range(5, 15)
	
	for i in range(NumberOfMeteros):
		randomize()
		var x = randi() % packed_scene.size() 
		location.x = rand_range(1240,window_size.x)
		location.y = rand_range(1,window_size.y)
		var scene =  packed_scene[x].instance()
		scene.position = location
		
		add_child(scene)

func phase_actions():
	phase_control()
	spawn_boss(current_phase)
		
	
func phase_control():
	current_time_passed = OS.get_system_time_secs() - phase_start_time
	if(current_time_passed < 3 and init_phase == false):
		$InitBackground.show()
		$initMessage.text = BEGINS_SENTENCES[current_phase]
		$initMessage.show()
	else:
		if(init_phase == false):
			phase_start_time = OS.get_system_time_secs()
			init_phase = true
			Global.control_shot = true
			$initMessage.hide()
			$InitBackground.hide()
			$Music_Fase.set_stream(PHASE_MUSIC[current_phase])
			$Music_Fase.play()
			spawn_enemys()
		
	if((current_time_passed/PHASE_TIME[current_phase]) >= 0.90 and (current_time_passed/PHASE_TIME[current_phase]) <= 0.95):
		$bossMessage.show()
	else:
		$bossMessage.hide()
	
	respawn_enemy()

func respawn_enemy():
	if(current_time_passed - spawn_control == 15 and boss_fight == false):
		spawn_control = current_time_passed
		spawn_enemys()

func _on_Boss_boss_killed(phase):
	if(phase == 2):
		Global._reset_values()
		boss_fight = false
		init_phase = false
		get_tree().change_scene("res://Scenes/WinScreen.tscn")
	else:
		start_phase(phase + 1)
		boss_fight = false
		init_phase = false
