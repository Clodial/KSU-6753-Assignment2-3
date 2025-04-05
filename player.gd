extends CharacterBody3D
signal hit
signal instant_death

@export var speed = 14
@export var jump_impulse = 20
@export var bounce_impulse = 30
@export var fall_acceleration = 75
@export var  jump_fall = 10 
@export var bullet_instance: PackedScene

var target_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	#basic input movement
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_just_pressed("shoot_action"):
		var bullet = bullet_instance.instantiate()
		owner.add_child(bullet)
		bullet.transform = $pivot/bulletMarker.global_transform
		bullet.transform.scaled(Vector3(0.3, 0.3, 0.3))

	#direction movement
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$pivot.basis = Basis.looking_at(direction)

	#ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		if Input.is_action_just_released("move_jump"):
			if target_velocity.y < -jump_fall:
				target_velocity.y = -jump_fall
				
	#Jumping
	if is_on_floor() and Input.is_action_just_pressed("move_jump"):
		target_velocity.y = jump_impulse
	
	#Collision checking based on top of enemy
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
				break
	
	velocity = target_velocity
	move_and_slide()
	
	if direction != Vector3.ZERO:
		$AnimationPlayer.speed_scale = 4
	else: 
		$AnimationPlayer.speed_scale = 1
	$pivot.rotation.x = PI/6 * velocity.y / jump_impulse
	
	if position.y < -2.0:
		instadie()

func die():
	hit.emit()
	target_velocity.y = bounce_impulse

func instadie():
	instant_death.emit()
	queue_free()

func _on_mob_detector_body_entered(body: Node3D) -> void:
	body.queue_free()
	die()
