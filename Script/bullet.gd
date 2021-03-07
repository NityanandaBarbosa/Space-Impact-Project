extends Area2D

export var speed: float = 40

func _physics_process(delta):
	position.x += speed + delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group("damageable"):
		if area.is_visible_in_tree():
			area.damage(1)
			queue_free()
	if area.is_in_group("boss"):
		if area.is_visible_in_tree():
			area.damage(1)
			queue_free()
