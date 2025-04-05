extends Area3D
signal coin_score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randf_range(-33.0, 33.0)
	position.z = randf_range(-33.0, 33.0)
	position.y = 3.0

func initialize():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func score():
	print("score")
	coin_score.emit()
	queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		score()
