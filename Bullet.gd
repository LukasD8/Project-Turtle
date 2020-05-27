extends KinematicBody2D
var z = 0
func _physics_process(delta):
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Wolf" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
