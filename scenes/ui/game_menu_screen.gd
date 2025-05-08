extends CanvasLayer

@onready var settings_game_button: Button = $MarginContainer/MarginContainer2/VBoxContainer/SettingsGameButton as Button
@onready var save_game_button: Button = $MarginContainer/MarginContainer2/VBoxContainer/SaveGameButton
var settings_menu_screen = preload("res://scenes/ui/settings_menu.tscn")


func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE
	handle_connecting_signals()

func _on_start_game_button_pressed() -> void:
	GameManager.start_game() 
	queue_free()# Replace with function body.


func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game() # Replace with function body.

func on_options_pressed() -> void:
	print("LOAD OPTIONS MENU")

func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game() # Replace with function body.


func handle_connecting_signals() -> void:
	settings_game_button.button_down.connect(on_options_pressed)
