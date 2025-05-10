class_name HotKeyRebindButton
extends Control


@onready var label: Label = $HBoxContainer/Label as Label
@onready var button: Button = $HBoxContainer/Button as Button

@export var action_name : String = "walk_up"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
	
func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"walk_up":
			label.text = "Walk Up"
		"walk_down":
			label.text = "Walk Down"
		"walk_left":
			label.text = "Walk Left"
		"walk_right":
			label.text = "Walk Right"
			
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode
	
	
	
	
	
