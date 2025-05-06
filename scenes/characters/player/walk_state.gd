extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 1

func _on_process(_delta : float) -> void:
	pass


#func _on_physics_process(_delta : float) -> void:
	#var direction: Vector2 = GameInputEvents.movement_input()
	#
	#if direction == Vector2.UP:
		#animated_sprite_2d.play("walk_back")
	#elif direction == Vector2.RIGHT:
		#animated_sprite_2d.play("walk_right")
	#elif direction == Vector2.DOWN:
		#animated_sprite_2d.play("walk_front")
	#elif direction == Vector2.LEFT:
		#animated_sprite_2d.play("walk_left")
#
	#if direction != Vector2.ZERO:
		## Choose dominant axis for animation
		#if abs(direction.x) > abs(direction.y):
			#animated_sprite_2d.play("walk_right" if direction.x > 0 else "walk_left")
		#else:
			#animated_sprite_2d.play("walk_front" if direction.y > 0 else "walk_back")
	#else:
		#animated_sprite_2d.stop()
#
	#player.velocity = direction * speed
	#player.move_and_slide()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	# If there is input, move and update facing
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		player.velocity = direction * speed
		player.player_direction = direction  # ✅ Save direction for idle
	else:
		player.velocity = Vector2.ZERO

	# Always animate based on last direction
	var anim_dir = player.player_direction

	if direction != Vector2.ZERO:
		# Play walk animation based on current input
		if abs(direction.x) > abs(direction.y):
			animated_sprite_2d.play("walk_right" if direction.x > 0 else "walk_left")
		else:
			animated_sprite_2d.play("walk_front" if direction.y > 0 else "walk_back")
	else:
		# Play idle animation based on last facing direction
		var idle_dir = player.player_direction
		if abs(idle_dir.x) > abs(idle_dir.y):
			animated_sprite_2d.play("idle_right" if idle_dir.x > 0 else "idle_left")
		else:
			animated_sprite_2d.play("idle_front" if idle_dir.y > 0 else "idle_back")

	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
