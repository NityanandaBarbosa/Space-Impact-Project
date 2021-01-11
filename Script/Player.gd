extends Area2D

var speed: float = 350
var vel := Vector2(0,0)

func _process(delta):
	pass
	
func _physics_process(delta):
	var dirVec := Vector2(0,0)
	 
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	#This two lines blocks de player to get out the screen
	var viewRect := get_viewport_rect()
	position.y = clamp(position.y,0, viewRect.size.y)
