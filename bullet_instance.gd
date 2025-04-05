extends Area3D
@export var speed = -50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta):
	position += basis.z * speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.position.x > 35.0 || self.position.x < -35.0 || self.position.z > 35.0 || self.position.z < -35.0:
		explode()
	
func explode():
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("mob"):
		var mob = body
		mob.shoot()
		explode()
	elif body.is_in_group("sp_mob"):
		explode()
