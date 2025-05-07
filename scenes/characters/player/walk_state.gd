extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 1

var cur_move

var chopping := false  # Add this as a class variable if not already
var tilling := false
var watering := false
var plantingcorn := false
var plantingtomato := false

func _physics_process(delta: float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	var using_tool := GameInputEvents.use_tool()
	cur_move = player.velocity

	# Handle chop input
	if using_tool and player.current_tool == DataTypes.Tools.AxeWood and not chopping:
		chopping = true
		player.velocity = Vector2.ZERO  # Prevent movement while chopping

		# Use the player’s current movement direction for the chop animation
		var chop_dir = player.player_direction
		if abs(chop_dir.x) > abs(chop_dir.y):
			animated_sprite_2d.play("chopping_right" if chop_dir.x > 0 else "chopping_left")
		else:
			animated_sprite_2d.play("chopping_front" if chop_dir.y > 0 else "chopping_back")

		# Connect animation finished signal to reset chopping
		animated_sprite_2d.connect("animation_finished", Callable(self, "_on_action_finished"), CONNECT_ONE_SHOT)

	# Skip input if currently chopping
	if chopping:
		player.velocity = Vector2.ZERO
		player.move_and_slide()
		return

# Handle tilling input
	if using_tool and player.current_tool == DataTypes.Tools.TillGround and not chopping:
		tilling = true
		player.velocity = Vector2.ZERO  # Prevent movement while chopping

		# Use the player’s current movement direction for the chop animation
		var till_dir = player.player_direction
		if abs(till_dir.x) > abs(till_dir.y):
			animated_sprite_2d.play("tilling_right" if till_dir.x > 0 else "tilling_left")
		else:
			animated_sprite_2d.play("tilling_front" if till_dir.y > 0 else "tilling_back")

		# Connect animation finished signal to reset chopping
		animated_sprite_2d.connect("animation_finished", Callable(self, "_on_action_finished"), CONNECT_ONE_SHOT)

	# Skip input if currently chopping
	if tilling:
		player.velocity = Vector2.ZERO
		player.move_and_slide()
		return

	# Handle movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		player.velocity = direction * speed
		player.player_direction = direction  # Update player movement direction
	else:
		player.velocity = Vector2.ZERO

	# Walk or idle animation based on movement
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			animated_sprite_2d.play("walk_right" if direction.x > 0 else "walk_left")
		else:
			animated_sprite_2d.play("walk_front" if direction.y > 0 else "walk_back")
	else:
		var idle_dir = player.player_direction
		if abs(idle_dir.x) > abs(idle_dir.y):
			animated_sprite_2d.play("idle_right" if idle_dir.x > 0 else "idle_left")
		else:
			animated_sprite_2d.play("idle_front" if idle_dir.y > 0 else "idle_back")

	player.move_and_slide()


#func _physics_process(delta: float) -> void:
	#var direction: Vector2 = GameInputEvents.movement_input()
	#var using_tool := GameInputEvents.use_tool()
	#cur_move = player.velocity
#
	## Handle chop input
	#if using_tool and player.current_tool == DataTypes.Tools.AxeWood and not chopping:
		#chopping = true
		#player.velocity = Vector2.ZERO  # Prevent movement
#
		## Determine chop direction based on mouse position
		#var mouse_pos = get_viewport().get_mouse_position()
		#var camera := get_viewport().get_camera_2d()
		#var world_mouse_pos = camera.get_screen_position_to_world(mouse_pos)
		#
		#var chop_dir = (world_mouse_pos - player.global_position).normalized()
		#player.player_direction = chop_dir  # Update facing direction
#
		## Choose chop animation based on direction to mouse
		#if abs(chop_dir.x) > abs(chop_dir.y):
			#animated_sprite_2d.play("chop_right" if chop_dir.x > 0 else "chop_left")
		#else:
			#animated_sprite_2d.play("chop_front" if chop_dir.y > 0 else "chop_back")
#
		## Connect signal to reset chopping after animation ends
		#animated_sprite_2d.connect("animation_finished", Callable(self, "_on_chop_finished"), CONNECT_ONE_SHOT)
#
	## Skip movement and animation while chopping
	#if chopping:
		#player.velocity = Vector2.ZERO
		#player.move_and_slide()
		#return
#
	## Handle movement input
	#if direction != Vector2.ZERO:
		#direction = direction.normalized()
		#player.velocity = direction * speed
		#player.player_direction = direction
	#else:
		#player.velocity = Vector2.ZERO
#
	## Play walking animations
	#if direction != Vector2.ZERO:
		#if abs(direction.x) > abs(direction.y):
			#animated_sprite_2d.play("walk_right" if direction.x > 0 else "walk_left")
		#else:
			#animated_sprite_2d.play("walk_front" if direction.y > 0 else "walk_back")
	#else:
		## Idle animation based on last facing direction
		#var idle_dir = player.player_direction
		#if abs(idle_dir.x) > abs(idle_dir.y):
			#animated_sprite_2d.play("idle_right" if idle_dir.x > 0 else "idle_left")
		#else:
			#animated_sprite_2d.play("idle_front" if idle_dir.y > 0 else "idle_back")
#
	#player.move_and_slide()


func _on_action_finished():
	chopping = false
	tilling = false
	watering = false
	plantingcorn = false
	plantingtomato = false






func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
