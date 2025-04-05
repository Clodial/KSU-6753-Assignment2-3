extends Control
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health.show()
	$health2.show()
	$health3.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health == 2:
		print("health down")
		$health3.hide()
	if health == 1:
		$health2.hide()
	if health == 0:
		$health.hide()

func _display_health():
	health -= 1
