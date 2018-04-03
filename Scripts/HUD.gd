# HUD Script
# @F1r3f0x - 2018

extends CanvasLayer

signal start_game


# Shows a message then dissapears, uses the MessageTimer
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func _on_MessageTimer_timeout():
    $MessageLabel.hide()


# Shows Game Over and allows to restart the game	
func show_game_over():
    show_message("Game Over")
    yield($MessageTimer, "timeout") # Resumes execution when the signal timeout of MessageTimer fires
    $StartButton.show()
    $MessageLabel.text = "Dodge the\nCreeps!"
    $MessageLabel.show()


func _on_StartButton_pressed():
    $StartButton.hide()
    emit_signal("start_game")
	

func update_score(score):
    $ScoreLabel.text = str(score)