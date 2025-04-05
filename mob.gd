extends CharacterBody3D
signal squashed
signal shot

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(_delta):
	
	move_and_slide()
	
	if self.position.x > 35.0 || self.position.x < -35.0 || self.position.z > 35.0 || self.position.z < -35.0:
		queue_free()

#function to be called from main scene
func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	rotate_y(randf_range(-PI/4, PI/4))
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	$AnimationPlayer.speed_scale = random_speed/min_speed
	self.position.y = 1.0

func squash():
	squashed.emit()
	queue_free()
	
func shoot():
	shot.emit()
	queue_free()
