extends CanvasLayer

@onready var save_game_button: Button = $MarginContainer/MarginContainer2/VBoxContainer/SaveGameButton



func _ready() -> void:
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = SaveGameManager.allow_save_game if Control.FOCUS_ALL else Control.FOCUS_NONE

func _on_start_game_button_pressed() -> void:
	GameManager.start_game() 
	queue_free()# Replace with function body.


func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game() # Replace with function body.


func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game() # Replace with function body.


func _on_settings_game_button_pressed() -> void:
	pass # Replace with function body.
