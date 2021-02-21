extends Node2D

signal boss_fight_start(phase_number)
signal boss_fight_ends(phase_number)
signal phase_change(phase_number)

var current_phase = null 
var phase_start_time = null
var current_time_passed = 0
var boss_fight = false

const PHASE_BACKGROUND = [
	"res://Assests/Background/backgroud-phase-1.png", 
	"res://Assests/Background/backgroud-phase-2.png", 
	"res://Assests/Background/backgroud-phase-3.png"
]
const PHASE_TIME = [60, 90, 120]

func _ready():
	start_phase(0)

func _process(delta):
	process_frame()
	
func start_phase(phase_number):
	current_phase = phase_number
	$background.texture = load(PHASE_BACKGROUND[current_phase])
	phase_start_time = OS.get_system_time_secs()

func process_frame():
	current_time_passed = OS.get_system_time_secs() - phase_start_time
	if (current_time_passed >= PHASE_TIME[current_phase]):
		if(!boss_fight):
			spawn_boss(current_phase)

func spawn_boss(phase_number):
	emit_signal("boss_fight_start", phase_number)
	boss_fight = true

func _on_Boss_1_boss_killed():
	emit_signal("boss_fight_ends", current_phase)
	start_phase(current_phase + 1)
	boss_fight = false
