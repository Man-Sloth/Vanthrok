extends Area2D

@onready var game_manager = $"../GameManager"
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var backpack = %Backpack
@onready var char_window = %CharacterWindow

@export_group("Item Properties")
enum ITEM_TYPE {Helm, Chest, Leggings, Gauntlets, Weapon, Shield, Stackable, Non_Stackable = -1}
@export var Item_Type: ITEM_TYPE
enum ARMOR_TYPE {CLOTH = -1}
@export var Armor_Type: ARMOR_TYPE


var close_to_player = false
var mouse_hover = false
var holding = false
var object_animations = SpriteFrames.new()
var dummy_image = Sprite2D.new()
var stack_size = 0
var inventory_slot = -1
var path = ""
var dummy_path = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	update_stats()

func _process(_delta):
	pass
	
func _input(event):
	var holdOffset = Vector2(115,170)
	if close_to_player:
		if mouse_hover:
			if event.is_action_pressed("pickup"):
				holding = true
				game_manager.set_holding(true)
				game_manager.set_held_object($".")
				game_manager.set_held_position(event.position - holdOffset)		
				
func get_item_type():
	return Item_Type
	
func set_item_type(type):
	Item_Type = type
	
func get_armor_type():
	return Armor_Type

func set_armor_type(armorT):
	Armor_Type = armorT
	
func get_inventory_slot():
	return inventory_slot
	
func set_inventory_slot(slot_number):
	inventory_slot = slot_number
	
func _on_body_entered(_body):
	close_to_player = true

func _on_body_exited(_body):
	close_to_player = false
	
func _on_mouse_entered():
	mouse_hover = true

func _on_mouse_exited():
	mouse_hover = false
	
func delete():
	queue_free()

func get_resource_path():
	return path

func set_resource_path(new_path):
	path = new_path
	
func get_dummy_path():
	return dummy_path
	
func get_frames():
	return object_animations

func set_frames(new_animation):
	object_animations = new_animation
	
func get_dummy():
	return dummy_image
	
func set_dummy(new_dummy):
	dummy_image.texture = new_dummy.texture

func load_animations():
	return load(path)
	
func update_stats():
	if Armor_Type == 0: #cloth
		if Item_Type == ITEM_TYPE.Chest:
			animated_sprite_2d.play("cloth_chest")
			path = "res://Assets/sprites/SpriteFrames/Human_Shirt.tres"
			dummy_path = "res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Chest_South.tres"
		elif Item_Type == ITEM_TYPE.Helm:
			animated_sprite_2d.play("cloth_helm")
		elif Item_Type == ITEM_TYPE.Gauntlets:
			animated_sprite_2d.play("cloth_arms")
		elif Item_Type == ITEM_TYPE.Leggings:
			animated_sprite_2d.play("cloth_pants")
		elif Item_Type == ITEM_TYPE.Weapon:
			animated_sprite_2d.play("level1_sword")
		elif Item_Type == ITEM_TYPE.Shield:
			animated_sprite_2d.play("level1_shield")
	


