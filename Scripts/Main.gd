# Main Script
# @F1r3f0x - 2018

extends Node

export (PackedScene) var Mob
var score


func _ready():
	randomize() # Randomizes the seed for rand functions.


# Game Over state
func game_over():
	# Stops timers
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	# Stop Music, play death sound
	$Music.stop()
	$DeathSound.play()
	
	# Show Game Over screen
	$HUD.show_game_over()


# Setup New Game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	$Music.play()


func _on_StartTimer_timeout():
    $MobTimer.start()
    $ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score +=1
	$HUD.update_score(score)


# Mob Spawner
func _on_MobTimer_timeout():
	# choose a random location on Path2D
	$MobPath/MobSpawnLocation.set_offset(randi())
	# create a Mob instance and add it to the scene
	var mob = Mob.instance()
	add_child(mob)
	# set the mob's direction perpendicular to the path direction -> PI/2 == 90º inwards
	# rotation is a float (radians)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	# set the mob's position to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	# add some randomness to the direction
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	# choose the velocity, uses physics
	mob.linear_velocity = Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction)