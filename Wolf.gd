extends KinematicBody2D

const GRAVITY = 10
const SPEED = 60
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1

func dead():
	$CollisionShape2D.call_deferred("set_disabled", true)
	queue_free()

func _physics_process(delta):
	velocity.x = SPEED * direction
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$RayCast2D.position.x = $RayCast2D.position.x * -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$RayCast2D.position.x = $RayCast2D.position.x * -1
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Bullet" in get_slide_collision(i).collider.name:
				dead()
			if "Player" in get_slide_collision(i).collider.name:
				get_tree().reload_current_scene()
