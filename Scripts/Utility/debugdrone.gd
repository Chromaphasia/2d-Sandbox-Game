extends CharacterBody2D

var health = 20:
	set(value):
		health = value
		if health <= 0:
			queue_free()

func takeDamage(damage):
	health -= damage

@export var speed := 20
var verticalPosition = position.y
var timer = 0
var state = 0
func _physics_process(delta):
	timer += delta
	if timer > 5.0:
		timer = 0
		state = (state+1) % 2
	if state == 1:
		move_and_slide()
	else:
		velocity = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))
		if position.y < verticalPosition - 30:
			velocity.y = abs(velocity.y)
		velocity *= speed
