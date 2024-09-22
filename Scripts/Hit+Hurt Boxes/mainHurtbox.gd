class_name Hurtbox
extends Area2D

@onready var parent = get_parent()
@onready var damageNumber = preload("res://Scenes/Utility Instanced Scenes/damage_number.tscn")

func _ready():
	collision_layer = 2
	collision_mask = 0


#var timer = 0.0
#func _process(delta):
#	timer += delta
#	if timer > 1.0:
#		timer = 0
#		hitboxInteraction([10,true])

func hitboxInteraction(damageInfo: Array):
	if parent.has_method("takeDamage"):
		parent.takeDamage(damageInfo[0])
		var damageNumberNode = damageNumber.instantiate()
		damageNumberNode.text = str(damageInfo[0])
		damageNumberNode.crit = damageInfo[1]
		add_child(damageNumberNode)
	else:
		push_error("Parent: "+parent.name+" does not have takeDamage method for hurtbox.")
	
