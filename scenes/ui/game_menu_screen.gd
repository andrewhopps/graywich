extends CanvasLayer

@onready var settings_game_button: Button = $MarginContainer/MarginContainer2/VBoxContainer/SettingsGameButton as Button
@onready var save_game_button: Button = $MarginContainer/MarginContainer2/VBoxContainer/SaveGameButton
@onready var options_menu: OptionsMenu = $Options_Menu as OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer


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
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game() # Replace with function body.

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false

func handle_connecting_signals() -> void:
	settings_game_button.button_down.connect(on_options_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
