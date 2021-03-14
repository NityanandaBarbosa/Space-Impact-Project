extends Area2D

export var speed: float = 15

func _physics_process(delta):
	position.x -= speed + delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Boss_1_Bullet_area_exited(area):
	if area.is_in_group("player"):
		Global._decrease_life()
		queue_free()
