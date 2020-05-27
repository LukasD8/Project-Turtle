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

func _process(delta):
	SkillLoop()

func SkillLoop():
	if Input.is_action_pressed("shoot") and can_fire == true:
		can_fire = false
		bullet_instance.position = $Position2D.get_global_position()
		bullet_instance.rotation = bullet_dir
		get_parent().add_child(bullet_instance)
		$Timer.start()
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		bullet_dir = 180
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Position2D.position.x = 36.353
	elif Input.is_action_pressed("ui_left"):
		bullet_dir = -180
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Position2D.position.x = -36.353
	else:
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
	
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Family" in get_slide_collision(i).collider.name:
				get_tree().change_scene("res://End.tscn")
			if "Wolf" in get_slide_collision(i).collider.name:
				get_tree().reload_current_scene()


func _on_Timer_timeout():
	
	get_parent().remove_child(bullet_instance)
