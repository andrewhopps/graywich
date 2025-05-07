class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	var dir := Vector2.ZERO  # Local, always fresh

	if Input.is_action_pressed("walk_left"):
		dir.x -= 1
	if Input.is_action_pressed("walk_right"):
		dir.x += 1
	if Input.is_action_pressed("walk_up"):
		dir.y -= 1
	if Input.is_action_pressed("walk_down"):
		dir.y += 1

	return dir.normalized()

static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else: return true
	
static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("hit")	
	
	return use_tool_value
