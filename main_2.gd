extends Node
@export var coin_scene: PackedScene
var health = 3
var score = 0

signal go_home

func _ready():
	$UserInterface/Retry.hide()
	$UserInterface/health4.hide()
	$UserInterface/health5.hide()
	$CoinTimer.start()

func _on_player_hit() -> void:
	var player = $Player
	health -= 1
	if health == 2:
		$UserInterface/health3.hide()
	if health == 1:
		$UserInterface/health2.hide()
	if health == 3:
		$UserInterface/health4.hide()
	if health == 4:
		$UserInterface/health5.hide()
	if health == 0:
		$UserInterface/health.hide()
		player.instadie()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") && $UserInterface/Retry.visible:
		score = $UserInterface/ScoreLabel._on_death()
		go_home.emit()

func _get_score():
	return score;

func _on_player_instant_death() -> void:
	$UserInterface/Retry.show()


func _on_start_timer_timeout() -> void:
	var player = $Player
	player.hit.connect($UserInterface._display_health())

func _on_score_label_new_life() -> void:
	if health < 5:
		health += 1
	if health == 2:
		$UserInterface/health2.show()
	if health == 1:
		$UserInterface/health.show()
	if health == 3:
		$UserInterface/health3.show()
	if health == 4:
		$UserInterface/health4.show()
	if health == 5:
		$UserInterface/health5.show()


func _on_coin_timer_timeout() -> void:
	var coin = coin_scene.instantiate()
	coin.initialize()
	
	coin.coin_score.connect($UserInterface/ScoreLabel._on_coin_score.bind())
	coin.coin_score.connect(self._on_coin_score.bind())
	add_child(coin)
	
func _on_coin_score():
	$CoinTimer.start()
