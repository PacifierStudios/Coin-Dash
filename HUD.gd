extends CanvasLayer

signal start_game

func _input(event):
    if $startButton.visible and event.is_action_pressed("ui_select"):
        $startButton.emit_signal("pressed")

func update_score(value):
    $marginContainer/scoreLabel.text = str(value)

func update_timer(value):
    $marginContainer/timeLabel.text = str(value)

func show_message(text):
    $messageLabel.text = text
    $messageLabel.show()
    $messageTimer.start()

func _on_gameTimer_timeout():
    $messageLabel.hide()

func _on_startButton_pressed():
    $startButton.hide()
    $messageLabel.hide()
    emit_signal("start_game")

func show_game_over():
    show_message("Game Over")
    yield($messageTimer, "timeout")
    $startButton.show()
    $messageLabel.text = "Coin Dash!"
    $messageLabel.show()