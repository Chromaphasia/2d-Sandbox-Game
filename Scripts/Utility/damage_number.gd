extends Label

var crit = false: 
	set(value):
		crit = value
		if crit:
			set("theme_override_colors/font_color",Color(.9,0.1,0.1,1.0))
# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= randf_range(.75,.9)
	velocity = Vector2(randf_range(-1.0,1.0),-5)

var velocity = Vector2()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_modulate = self_modulate
	current_modulate.a *= .98
	set_self_modulate(current_modulate)
	if current_modulate.a < .01:
		queue_free()
	scale *= .995
	velocity.y += .2
	position += velocity
	
