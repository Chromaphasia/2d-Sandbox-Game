class_name Hitbox
extends Area2D

@export var damage := [0,0]
@export var damageModifier := 0.0
@export var criticalChance := 0.0
@export var criticalDamageModifier := 1.0
@export var statusEffects:= PackedStringArray()
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",_on_hurtbox_enter)
	collision_layer = 0
	collision_mask = 2

#Function to calculate damage and crit
func calculateDamage() -> Array:
	var crit = false
	#Get random damage value between min and max
	var currentDamage = randf_range(damage[0],damage[1])
	#Apply damage modifier
	currentDamage = currentDamage * (1.0+damageModifier)
	#Rand for crit
	if randf() < criticalChance:
		#Applies crit modifier and sets crit to true
		currentDamage = currentDamage * (1.0+criticalDamageModifier)
		crit = true
	#Rounds damage to nearest whole number and keeps it typed int
	currentDamage = int(currentDamage)
	#Returns values
	return [currentDamage,crit]

func _on_hurtbox_enter(hurtbox: Hurtbox):
	print("hurtbox entered")
	#If the hurtbox belongs to the same node as the hitbox, ignore the collision.
	if hurtbox.get_parent() == get_parent():
		return
	#Safety Method Check
	
	if hurtbox.has_method("hitboxInteraction"):
		#Calculates damage and sends it to the hurtbox in order to damage the entity
		hurtbox.hitboxInteraction(calculateDamage())
	else:
		push_error("hurtbox: "+hurtbox.name+" lacks hitboxInteraction Method.")
	
