class_name GameInputEvents

static var direction: Vector2 = Vector2.ZERO

static func movement_input() -> Vector2:
	direction = Vector2.ZERO

	if Input.is_action_pressed("walk_left"):
		direction.x -= 1
	if Input.is_action_pressed("walk_right"):
		direction.x += 1
	if Input.is_action_pressed("walk_up"):
		direction.y -= 1
	if Input.is_action_pressed("walk_down"):
		direction.y += 1
	
	direction = direction.normalized()
	return direction

static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true

static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("hit")
	
	return use_tool_value
