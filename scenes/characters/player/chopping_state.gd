extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

var chopping := false
var using_tool := false

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 0)

	# Connect the animation finished signal
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_physics_process(_delta : float) -> void:
	if chopping:
		# Ensure the player doesn't move while chopping
		player.velocity = Vector2.ZERO
		player.move_and_slide()

		return  # Skip movement input during chopping

	# Handle normal movement if not chopping
	var direction: Vector2 = GameInputEvents.movement_input()
	if direction != Vector2.ZERO:
		player.velocity = direction * player.speed
		player.move_and_slide()  # Move the player based on the input

	# Check if the player is using the tool to start chopping
	using_tool = GameInputEvents.use_tool()
	if using_tool and player.current_tool == DataTypes.Tools.AxeWood and not chopping:
		print("Started chopping!")
		chopping = true  # Set chopping state to true
		player.velocity = Vector2.ZERO  # Stop movement immediately during chop
		player.move_and_slide()

		# Play chop animation based on player direction
		var chop_dir = player.player_direction
		if abs(chop_dir.x) > abs(chop_dir.y):
			animated_sprite_2d.play("chopping_right" if chop_dir.x > 0 else "chopping_left")
		else:
			animated_sprite_2d.play("chopping_front" if chop_dir.y > 0 else "chopping_back")

		print("Playing chop animation:", animated_sprite_2d.animation)

		return  # Skip movement input during the chop

func _on_animation_finished() -> void:
	# Animation finished, chop action is complete, transition to Idle
	print("🟢 Chopping animation finished, transitioning to Idle")
	chopping = false  # Reset chopping state
	transition.emit("Idle")  # Transition to Idle state

func _on_exit() -> void:
	print("🔴 Exiting chopping state")
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
