extends Area2D

var speed : float = -250

func _ready():
	pass

func _physics_process(delta):
	position.x  += speed * delta
		
	var viewRect := get_viewport_rect()
	position.y = clamp(position.y,0, viewRect.size.y)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Life_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("player"):
		Global._increase_life()
		queue_free()
