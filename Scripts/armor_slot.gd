extends TextureRect

@onready var game_manager = $"../../../../GameManager"
@onready var item_sprite = $item_sprite
@onready var player = $"../../../../RPG_Player"
@onready var chest_sprite = $"../../../../RPG_Player/Chest Sprite"
@onready var helmet_sprite = $"../../../../RPG_Player/Helm Sprite"
@onready var leggings_sprite = $"../../../../RPG_Player/Leggings Sprite"
@onready var gauntlets_sprite = $"../../../../RPG_Player/Gauntlet Sprite"
@onready var weapon_sprite = $"../../../../RPG_Player/Weapon Sprite"
@onready var shield_sprite = $"../../../../RPG_Player/Shield Sprite"

@onready var chest = $"../../Chest"
@onready var head = $"../../Head"
@onready var legs = $"../../Legs"
@onready var arms = $"../../Arms"
@onready var weapon = $"../../Weapon"
@onready var shield = $"../../Shield"

@export_group("Item Properties")
enum ITEM_TYPE {Helm, Chest, Legs, Arms, Weapon, Shield, Stackable, Non_Stackable = -1}
@export var Item_Type: ITEM_TYPE
var armor_type_last_frame = -1

const OBJECTSCENE = preload("res://Scenes/object.tscn")
const DUMMY_CLOTH_SHIRT = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Chest_South.tres")
const DUMMY_CLOTH_HAT = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Head_South.tres")
const DUMMY_CLOTH_LEGGINGS = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Legs_South.tres")
const DUMMY_CLOTH_GLOVES = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Arms_South.tres")
const DUMMY_LEVEL1_WEAPON = preload("res://Assets/sprites/Atlases/Characters/Cloth/Level1_Weapon_South.tres")
const DUMMY_LEVEL1_SHIELD = preload("res://Assets/sprites/Atlases/Characters/Cloth/Level1_Shield_South.tres")

var holdOffset = Vector2(115,170)

var hovering = false
var object = null
var slot_object = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(ITEM_TYPE.Helm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animate()
	
func _input(event):
	if hovering && game_manager.get_held_object() != null: # mouse is holding an item
		if game_manager.get_held_object().get_item_type() == Item_Type: # item can be dropped in this location
			if event.is_action_released("pickup"):
				object = game_manager.get_held_object()
				var item_type = object.get_item_type()
				var armor_type = object.get_armor_type()
				
				#if armor_type != armor_type_last_frame: # new armor type was placed in location. Need to load new asset
					#if armor_type == 0: #cloth
						#if item_type == 1: #chest
							#chest.texture = load("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Chest_South.tres")
							#chest.visible = true
							#chest_sprite.visible = true
							#player.set_chest_frames()
						#armor_type_last_frame = armor_type
				
				slot_object = OBJECTSCENE.instantiate()
				slot_object.visible = false
				slot_object.set_item_type(object.get_item_type())
				slot_object.set_frames(object.get_frames())
				slot_object.set_dummy(object.get_dummy())
				#slot_object.get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
				#slot_object.get_node("AnimatedSprite2D").sprite_frames = object.get_node("AnimatedSprite2D").sprite_frames
				add_child(slot_object)
				player.set_frames(slot_object)
				
				if item_type == 1: #chest
					chest.texture = slot_object.get_dummy().texture
					chest.visible = true
				
				if armor_type == 0: #cloth
					if item_type == 0: #head
						head.texture = DUMMY_CLOTH_HAT
						head.visible = true
						helmet_sprite.visible = true
					#elif item_type == 1: #chest
						#chest.texture = DUMMY_CLOTH_SHIRT
						#chest.visible = true
						chest_sprite.visible = true	
					elif item_type == 2: #leggings
						legs.texture = DUMMY_CLOTH_LEGGINGS
						legs.visible = true
						leggings_sprite.visible = true	
					elif item_type == 3: #gloves
						arms.texture = DUMMY_CLOTH_GLOVES
						arms.visible = true
						gauntlets_sprite.visible = true	
					elif item_type == 4: #weapon
						weapon.texture = DUMMY_LEVEL1_WEAPON
						weapon.visible = true
						weapon_sprite.visible = true	
					elif item_type == 5: #Shield
						shield.texture = DUMMY_LEVEL1_SHIELD
						shield.visible = true
						shield_sprite.visible = true	
				
				
					
				object.delete()
				game_manager.set_texture(null)
				game_manager.set_held_object(null)
				game_manager.set_pulled_location(null)
				game_manager.set_pulled_char_location(null)
				
		else: # item CANNOT be dropped at this location
			var slot = game_manager.get_pulled_char_location()
			var inv_slot = game_manager.get_pulled_location()
			if slot != null: #Pulled from another armor slot
				if event.is_action_released("pickup"):
					object = game_manager.get_held_object()
					var item_type = object.get_item_type()
					var armor_type = object.get_armor_type()
					slot.set_slot_object(OBJECTSCENE.instantiate())
					slot.get_slot_object().visible = false
					slot.get_slot_object().set_item_type(object.get_item_type())
					slot.add_child(slot.get_slot_object())
					slot.get_slot_object().get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
					
					if armor_type == 0: #cloth
						if item_type == 1: #chest
							#chest.texture = DUMMY_CLOTH_SHIRT
							chest.visible = true
							chest_sprite.visible = true
						elif item_type == 0: #Helm
							head.texture = DUMMY_CLOTH_HAT
							head.visible = true
							helmet_sprite.visible = true
						elif item_type == 2: #leggings
							legs.texture = DUMMY_CLOTH_LEGGINGS
							legs.visible = true
							leggings_sprite.visible = true	
						elif item_type == 3: #gloves
							arms.texture = DUMMY_CLOTH_GLOVES
							arms.visible = true
							gauntlets_sprite.visible = true	
						elif item_type == 4: #weapon
							weapon.texture = DUMMY_LEVEL1_WEAPON
							weapon.visible = true
							weapon_sprite.visible = true		
						elif item_type == 5: #Shield
							shield.texture = DUMMY_LEVEL1_SHIELD
							shield.visible = true
							shield_sprite.visible = true	
								
					object.delete()
					game_manager.set_texture(null)
					game_manager.set_held_object(null)
					game_manager.set_pulled_char_location(null)
					game_manager.set_holding(false)
			elif inv_slot != null: # pulled from a bag slot
				if event.is_action_released("pickup"):
					object = game_manager.get_held_object()
					var item_type = object.get_item_type()
					
					inv_slot.set_slot_object(OBJECTSCENE.instantiate())
					inv_slot.get_slot_object().visible = false
					inv_slot.get_slot_object().set_item_type(item_type)
					inv_slot.add_child(inv_slot.get_slot_object())
					inv_slot.get_slot_object().get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
					
					object.delete()
					game_manager.set_texture(null)
					game_manager.set_held_object(null)
					game_manager.set_pulled_location(null)
					game_manager.set_holding(false)
					
	elif hovering && game_manager.get_held_object() == null: # Mouse is NOT holding an item
		if event.is_action_pressed("pickup"): # pick up an item from this armor slot
			if slot_object != null:
				var item_type = slot_object.get_item_type()
				player.clear_spriteframes()
				game_manager.set_held_object(slot_object)
				game_manager.set_holding(true)
				game_manager.set_held_position(event.position - holdOffset)
				slot_object = null
				item_sprite.texture = null
				game_manager.set_pulled_char_location(self)
				
				#if armor_type == 0: #cloth
				if item_type == 1: #chest
					chest.texture =null
					chest.visible = false
					armor_type_last_frame = -1
					chest_sprite.visible = false
				elif item_type == 0: #head
					head.texture = null
					head.visible = false
					helmet_sprite.visible = false
				elif item_type == 2: #leggings
					legs.texture = null
					legs.visible = false
					leggings_sprite.visible = false
				elif item_type == 3: #gloves
					arms.texture = null
					arms.visible = false
					gauntlets_sprite.visible = false
				elif item_type == 4: #weapon
					weapon.texture = null
					weapon.visible = false
					weapon_sprite.visible = false
				elif item_type == 5: #Shield
					shield.texture = null
					shield.visible = false
					shield_sprite.visible = false
	
func animate():
	if slot_object != null:
		var animatedSprite2D = slot_object.get_node("AnimatedSprite2D")
		var frameIndex: int = animatedSprite2D.get_frame()
		var animationName: String = animatedSprite2D.animation
		var spriteFrames: SpriteFrames = animatedSprite2D.get_sprite_frames()
		item_sprite.texture = spriteFrames.get_frame_texture(animationName, frameIndex)
		
func _on_mouse_entered():
	game_manager.set_hovering_char_slot(true)
	hovering = true

func _on_mouse_exited():
	game_manager.set_hovering_char_slot(false)
	hovering = false
	
func set_slot_object(new_object):
	slot_object = new_object
	
func get_slot_object():
	return slot_object
	
func get_item_type():
	return Item_Type
	
func set_item_type(item_type):
	Item_Type = item_type
	
func get_object():
	return object
	
