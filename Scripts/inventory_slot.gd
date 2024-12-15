extends TextureRect

@onready var game_manager = $"../../../../../../GameManager"
@onready var item_sprite = $item_sprite
@onready var player = $"../../../../../../RPG_Player_New"

@export_group("Item Properties")
enum ITEM_TYPE {Helm, Chest, Legs, Arms, Weapon, Shield, Stackable, Non_Stackable, Empty = -1}
@export var Item_Type: ITEM_TYPE
const OBJECTSCENE = preload("res://Scenes/coin.tscn")
var holdOffset = Vector2(115,170)

var hovering = false
var object = null
var slot_object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate()
	
func _input(event):
	if hovering && game_manager.get_held_object() != null: #drop item into slot
		if event.is_action_released("pickup"):
			if slot_object == null:
				object = game_manager.get_held_object()
				slot_object = OBJECTSCENE.instantiate()
				slot_object.visible = false
				slot_object.set_item_type(object.get_item_type())
				Item_Type = slot_object.get_item_type()
				add_child(slot_object)
				slot_object.get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
				object.delete()
				game_manager.set_texture(null)
				game_manager.set_held_object(null)
				game_manager.set_pulled_location(null)
				game_manager.set_pulled_char_location(null)
			else:
				object = game_manager.get_held_object()
				var tmpObject = slot_object
				slot_object = object
				game_manager.get_pulled_location().set_slot_object(tmpObject)
				slot_object.update_stats()
				game_manager.get_pulled_location().get_slot_object().update_stats()
			
	elif hovering && game_manager.get_held_object() == null: #pick up item from slot
		if event.is_action_pressed("pickup"):
			if slot_object != null:
				game_manager.set_held_object(slot_object)
				game_manager.set_holding(true)
				game_manager.set_held_position(event.position - holdOffset)
				slot_object = null
				item_sprite.texture = null
				game_manager.set_pulled_location(self)
			
func animate():
	if slot_object != null:
		var animatedSprite2D = slot_object.get_node("AnimatedSprite2D")
		var frameIndex: int = animatedSprite2D.get_frame()
		var animationName: String = animatedSprite2D.animation
		var spriteFrames: SpriteFrames = animatedSprite2D.get_sprite_frames()
		item_sprite.texture = spriteFrames.get_frame_texture(animationName, frameIndex)
		
func _on_mouse_entered():
	game_manager.set_hovering_slot(true)
	hovering = true

func _on_mouse_exited():
	game_manager.set_hovering_slot(false)
	hovering = false
	
func set_slot_object(new_object):
	slot_object = new_object
	
func get_slot_object():
	return slot_object
	
func get_item_type():
	return Item_Type
	
func set_item_type(type):
	Item_Type = type
