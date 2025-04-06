extends CharacterBody3D

@export var speed = 4
var player_in_range = false
var direction
var target_velocity = Vector3.ZERO

func _physics_process(_delta):
	
	if(player_in_range):
		var player_pos = get_node("../Player").global_position
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(global_position, player_pos)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result && result.collider is CharacterBody3D:
			self.look_at(player_pos)
		
			direction = global_position.direction_to(player_pos)
			target_velocity.x = direction.x * speed
			target_velocity.z = direction.z * speed
			velocity = target_velocity
		else:
			velocity = Vector3.ZERO
	else:
		velocity = Vector3.ZERO
		
		
	
	move_and_slide()

func _on_follow_player_box_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		player_in_range = true


func _on_follow_player_box_body_exited(body: Node3D) -> void:
	if(body.is_in_group("player")):
		player_in_range = false
