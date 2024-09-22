extends CharacterBody2D


@export var speed := 300.0
@export var jumpVelocity := -400.0
@export var maxHealth := 100:
	set(value):
		maxHealth = value
		if health > maxHealth:
			health = maxHealth
@export var weaponType := "saber"
var health:
	set(value):
		health = value
		if health <= 0:
			#GAME OVER
			pass

func _ready():
	health = maxHealth

func takeDamage(damage):
	health -= damage


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play(weaponType+"Attack")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
	#Manually changes the direction the character fac	es with inputs
	if Input.is_action_just_pressed("moveLeft"):
		print("test1")
		transform.x.x = abs(transform.x.x)
	elif Input.is_action_just_pressed("moveRight"):
		#print("test2")
		transform.x.x = abs(transform.x.x)*-1.0
		#print(transform)
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction:
		#print(direction)
		#if direction < 0 and scale.x < 0:
	#		scale.x = 1.0
	#	elif direction > 0 and scale.x >	 0:
	#		scale.x = -1.0
		
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
