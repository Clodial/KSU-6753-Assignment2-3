extends Label
signal new_life
var score = 0
var hidden_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mob_squashed():
	score += 1
	hidden_score += 1
	text = "Score: %s" % score
	if hidden_score >= 50:
		new_life.emit()
		hidden_score -= 50

func _on_mob_shot():
	score += 3
	hidden_score += 3
	text = "Score: %s" % score
	if hidden_score >= 50:
		new_life.emit()
		hidden_score -= 50

func _on_coin_score():
	score += 20
	hidden_score += 20
	text = "Score: %s" % score
	if hidden_score >= 50:
		new_life.emit()
		hidden_score -= 50
