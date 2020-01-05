extends Node

export (PackedScene) var Coin
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false

func _ready():
    randomize()
    screensize = get_viewport().get_visible_rect().size
    $player.screensize = screensize
    $player.hide()
    if score == null: 
        score = 0
    if time_left == null:
        time_left = 0
    $HUD.update_score(score)
    $HUD.update_timer(time_left)

func new_game():
    playing = true
    level = 1
    score = 0
    time_left = playtime
    $player.start($playerStart.position)
    $player.show()
    $gameTimer.start()
    spawn_coins()

func spawn_coins():
    for i in range(4 + level):
        var c = Coin.instance()
        $CoinContainer.add_child(c)
        c.screensize = screensize
        c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

func _process(delta):
    if playing and $CoinContainer.get_child_count() == 0:
        level +=1
        time_left +=5
        spawn_coins()

func _on_gameTimer_timeout():
    time_left -= 1
    $HUD.update_timer(time_left)
    if time_left <= 0:
        game_over()

func _on_player_pickup():
    score += 1
    $HUD.update_score(score)

func _on_player_hurt():
    game_over()

func game_over():
    playing = false
    $gameTimer.stop()
    for coin in $CoinContainer.get_children():
        coin.queue_free()
    $HUD.show_game_over()
    $player.die()

