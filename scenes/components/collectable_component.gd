class_name CollectableComponent
extends Area2D

@export var collectable_name: String
@export var itemRes: InventoryItem

#func _on_body_entered(body: Node2D) -> void:
	#if body is Player:
		#InventoryManager.add_collectable(collectable_name)
		#print("Collected:", collectable_name)
		#get_parent().queue_free()

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
