class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

@export var speed = 70
var player_direction: Vector2
var input_movement = Vector2.ZERO

@export var inventory: Inventory

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)

func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool

func _physics_process(delta: float) -> void:
	move()
	handleCollision()

func move():
	input_movement = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Chop/blend_position", input_movement)
		anim_state.travel("Walk")
		velocity = input_movement * speed
		
	if input_movement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("hit"):	
		update_tool_anim()
		
	move_and_slide()

func update_tool_anim():
	anim_state.travel("Chop")
	#if player_direction.x > 0:
		#$AnimationPlayer.play("PlayerAnimations/chopping_right")
	#if player_direction.x < 0:
		#$AnimationPlayer.play("PlayerAnimations/chopping_left")
	#if player_direction.y > 0:
		#$AnimationPlayer.play("PlayerAnimations/chopping_down")
	#if player_direction.y < 0:
		#$AnimationPlayer.play("PlayerAnimations/chopping_up")

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
		
