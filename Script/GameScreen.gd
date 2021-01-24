extends Node2D

var current_phase = null # 0 - phase 1; 1 - phase 2; 2 - phase 3
var phase_start_time = null
var current_time_passed = 0

const PHASE_BACKGROUND = [
	"res://Assests/Background/backgroud-phase-1.png", 
	"res://Assests/Background/backgroud-phase-2.png", 
	"res://Assests/Background/backgroud-phase-3.png"
]
const PHASE_TIME = [90, 120, 180]

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
		start_phase(current_phase + 1)
