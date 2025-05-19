extends CanvasLayer

@onready var inventory = $InventoryGui

func _ready():
	inventory.close()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_inventory"):
		if inventory.isOpen:
			inventory.close()
		else:
			inventory.open()
