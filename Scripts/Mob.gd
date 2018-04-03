# Mob Script
# @F1r3f0x - 2018
 
extends RigidBody2D

export (int) var MIN_SPEED # minimum speed range
export (int) var MAX_SPEED # maximum speed range
var mob_types = ["walk", "swim", "fly"]


func _ready():
	# Set random animation
	var randIndex = randi() % mob_types.size()  # Get random index (0 - mob_types.size()-1)
	$AnimatedSprite.animation = mob_types[randIndex]


# Removes mobs when is out of the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()