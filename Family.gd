extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -400

var motion = Vector2()
var bullet = preload("res://Bullet.tscn")
var bullet_instance = bullet.instance()
var can_fire = true
var rate_of_fire = 0.4
var bullet_dir = 180





func _physics_process(delta):
	motion.y += GRAVITY
	
	if is_on_floor():
		motion.y = 0
	
	motion = move_and_slide(motion, UP)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_tree().change_scene("res://End.tscn")
