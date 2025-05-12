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
		"interact":
			label.text = "Interact"
		"hotbar1":
			label.text = "Hotbar 1"
		"hotbar2":
			label.text = "Hotbar 2"
		"hotbar3":
			label.text = "Hotbar 3"	
		"hotbar4":
			label.text = "Hotbar 4"	
		"hotbar5":
			label.text = "Hotbar 5"	
		"hotbar6":
			label.text = "Hotbar 6"
		"hotbar7":
			label.text = "Hotbar 7"	
		"hotbar8":
			label.text = "Hotbar 8"	
		"hotbar9":
			label.text = "Hotbar 9"
		"hotbar10":
			label.text = "Hotbar 10"
		"hotbar11":
			label.text = "Hotbar 11"	
		"hotbar12":
			label.text = "Hotbar 12"		
					
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode
	
	
	

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
