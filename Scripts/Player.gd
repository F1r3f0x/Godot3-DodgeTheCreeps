# Player Script
# @F1r3f0x - 2018

extends Area2D

signal hit

# Consts
export (int) var SPEED
export (bool) var HIDDEN  # Start Hidden?

# Vars
var screensize


func _ready():
	if HIDDEN:
		hide()
		
	screensize = get_viewport_rect().size
	

# Sets the initial position and then shows the player and activates the collisions
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false  # Activates collisions


func _process(delta):
	# Getting Input
	var direction = get_input_direction()
	
	# Calculating Velocity, start movement animations
	var velocity = Vector2()
	if direction.length() > 0:
		velocity = direction.normalized() * SPEED
		$Trail.emitting = true
		$AnimatedSprite.play()
	else:
		$Trail.emitting = false
		$AnimatedSprite.stop()
		
	# Animating
	if velocity.y != 0:
	    $AnimatedSprite.animation = "up"
	    $AnimatedSprite.flip_v = velocity.y > 0
	    $AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.x != 0:
	    $AnimatedSprite.animation = "right"
	    $AnimatedSprite.flip_v = false
	
	# Updating Position
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	

func get_input_direction():
	var direction = Vector2()
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	return direction


func _on_Player_body_entered(body):
	hide() # Player disappears after being hit
	emit_signal("hit")
	$CollisionShape2D.disabled = true