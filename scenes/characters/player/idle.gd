class_name State extends Node

var subject:CharacterBody2D
var direction:Vector2

signal new_state_request(state:State)


func _enter() -> void:
	push_error("_enter function not implemented in state %s" % self.name)


func _leave() -> void:
	push_error("_leave function not implemented in state %s" % self.name)


func _state_process(_delta:float) -> void:
	push_error("state_process function not implemented in state %s" % self.name)


func _is_available() -> bool:
	return true
