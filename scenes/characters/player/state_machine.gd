class_name StateMachine
extends Node

@export var use_anim_player:bool = false
@export var anim_player:AnimationPlayer
@export var subject:CharacterBody2D
@export var _initial_state:State

var current_state:State:set = _set_current_state


func _enter_tree() -> void:
	current_state = _initial_state
	for child:State in get_children():
		child.subject = subject
		child.new_state_request.connect(on_new_state_requested)


func on_new_state_requested(state:State) -> void:
	current_state = state
	current_state._enter()


func _set_current_state(new_state: State) -> void:
	if current_state:
		current_state._leave()
	current_state = new_state
	if use_anim_player:
		set_animation()


func set_animation() -> void:
	var anim_name:StringName = current_state.name.to_lower()
	if anim_player.has_animation(anim_name):
		anim_player.play(anim_name)


func _physics_process(delta:float) -> void:
	current_state._state_process(delta)
