extends Area2D

var plBullet := preload("res://Scenes/Player/bullet.tscn")

export var speed: float = 300
export var fireDelay: float = 0.1

onready var normalGun := $FireGun
onready var gunsPosition := $SpecialGuns
onready var fireDelayTimer := $FireDelayerTimer


var vel := Vector2(0,0)

func _process(delta):
	
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		var bulllet := plBullet.instance()
		bulllet.global_position = normalGun.global_position
		get_tree().current_scene.add_child(bulllet)
		$sfx_shot.play()
		#for child in gunsPosition.get_children():
		#	var bulllet := plBullet.instance()
		#	bulllet.global_position = child.global
		#	get_tree().current_scene.add_child(bulllet)
	
func _physics_process(delta):
	var dirVec := Vector2(0,0)
	 
	if Input.is_action_pressed("move_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("move_down"):
		dirVec.y = 1
	if Input.is_action_pressed("move_right"):
		dirVec.x = 1
	elif Input.is_action_pressed("move_left"):
		dirVec.x = -1
	
	vel = dirVec.normalized() * speed
	position += vel * delta
	
	#This two lines blocks de player to get out the screen
	var viewRect := get_viewport_rect()
	position.y = clamp(position.y,0, viewRect.size.y)
	position.x = clamp(position.x,0, viewRect.size.x)
	
func damage(amount: int):
	Global._enemykilled(1)
	
