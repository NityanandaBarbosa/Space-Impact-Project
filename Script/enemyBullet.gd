extends Area2D

export var speed: float = 10

func _physics_process(delta):
	position.x -= speed + delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group("player"):
		Global.life -= 1
		queue_free()
