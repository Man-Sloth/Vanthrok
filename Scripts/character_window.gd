extends Panel

@onready var vanthrok = $"../.."
@onready var character_window = $"."
@onready var exit_window = $"Exit Window"
@onready var resize_window = $"Resize Window"
@onready var title_plate = $"Title Plate"
@onready var panel_container = $"PanelContainer"
@onready var game_manager = %GameManager
@onready var player = $"../../RPG_Player"

@onready var chest = $Chest
@onready var cloth_shirt_sprite = $"../../RPG_Player/Shirt/Cloth Shirt Sprite"
@onready var head = $Head
@onready var cloth_helmet_sprite = $"../../RPG_Player/Hat/Cloth Helmet Sprite"
@onready var legs = $Legs
@onready var cloth_pants_sprite = $"../../RPG_Player/Pants/Cloth Pants Sprite"


var resizing = false
var moving = false
var moving_start = Vector2(0,0)
var character_window_start = Vector2(0,0)
var hovering = false
var inventory_hover = false
const OBJECTSCENE = preload("res://Scenes/coin.tscn")
const DUMMY_CLOTH_SHIRT = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Chest_South.tres")
const DUMMY_CLOTH_HELMET = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Head_South.tres")
const DUMMY_CLOTH_LEGGINGS = preload("res://Assets/sprites/Atlases/Characters/Cloth/Cloth_Legs_South.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	window_resize()
	window_move()
	
func _input(event):
	if event.is_action_pressed("character_toggle"):
		toggle_menu()
		
	if hovering && game_manager.get_held_object() != null: #Drop item back to previous slot
		if event.is_action_released("pickup"):
			var slot = game_manager.get_pulled_char_location()
			var inv_slot = game_manager.get_pulled_location()
			if slot != null:
				var object = game_manager.get_held_object()
				var item_type = object.get_item_type()
				var armor_type = object.get_armor_type()
				slot.set_slot_object(OBJECTSCENE.instantiate())
				slot.get_slot_object().visible = false
				slot.get_slot_object().set_item_type(object.get_item_type())
				slot.add_child(slot.get_slot_object())
				slot.get_slot_object().get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
				
				if armor_type == 0: #cloth
					if item_type == 1: #chest
						chest.texture = DUMMY_CLOTH_SHIRT
						chest.visible = true
						cloth_shirt_sprite.visible = true
					elif item_type == 0: #helmet
						head.texture = DUMMY_CLOTH_HELMET
						head.visible = true
						cloth_helmet_sprite.visible = true
					elif item_type == 2: #leggings
						legs.texture = DUMMY_CLOTH_LEGGINGS
						legs.visible = true
						cloth_pants_sprite.visible = true
				object.delete()
				game_manager.set_texture(null)
				game_manager.set_held_object(null)
				game_manager.set_pulled_char_location(slot)
				game_manager.set_holding(false)
			elif inv_slot != null:
				var object = game_manager.get_held_object()
				inv_slot.set_slot_object(OBJECTSCENE.instantiate())
				inv_slot.get_slot_object().visible = false
				inv_slot.get_slot_object().set_item_type(object.get_item_type())
				inv_slot.add_child(inv_slot.get_slot_object())
				inv_slot.get_slot_object().get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
				
				object.delete()
				game_manager.set_texture(null)
				game_manager.set_held_object(null)
				game_manager.set_pulled_location(null)
				game_manager.set_holding(false)
	elif !hovering && !game_manager.get_hovering_char_slot(): #Drop item out of window
		if event.is_action_released("pickup"):
			var slot = game_manager.get_pulled_char_location()
			if slot != null:
				if !game_manager.get_hovering_slot():
					if !game_manager.get_hovering_window():
						var object = game_manager.get_held_object()
						var dropped_object = OBJECTSCENE.instantiate()
						dropped_object.set_item_type(object.get_item_type())
						vanthrok.add_child(dropped_object)
						dropped_object.get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
						dropped_object.position = player.position
						dropped_object.z_index = 1
						dropped_object.y_sort_enabled = true
						dropped_object.set_item_type(slot.get_item_type())
						
						object.delete()
						game_manager.set_texture(null)
						game_manager.set_held_object(null)
						game_manager.set_pulled_location(null)
						game_manager.set_pulled_char_location(null)
						game_manager.set_holding(false)
					#else:
						#var object = game_manager.get_held_object()
						#slot.set_slot_object(OBJECTSCENE.instantiate())
						#slot.get_slot_object().visible = false
						#slot.set_item_type(object.get_item_type())
						#add_child(slot.get_slot_object())
						#slot.get_slot_object().get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
						#object.delete()
						#game_manager.set_texture(null)
						#game_manager.set_held_object(null)
						#game_manager.set_pulled_char_location(slot)
						#game_manager.set_holding(false)
		
func toggle_menu():
	if self.visible:
		self.visible = false
	else:
		self.visible = true

func window_resize():
	var speed = get_viewport_rect().size.x * 0.00001
	var resizeDiff = abs(resize_window.position.x - get_local_mouse_position().x)
	if resizing:
		if resizeDiff > 20:
			if resize_window.position.x + (resize_window.size.x/3) > (get_local_mouse_position().x + 0.1):
				character_window.scale.x += (speed)
				character_window.scale.y += (speed)
			elif resize_window.position.x + (resize_window.size.x/3) < (get_local_mouse_position().x -0.1):
				character_window.scale.x -= (speed)
				character_window.scale.y -= (speed)
				if character_window.scale.x < 0.5:
					character_window.scale.x = 0.5
					character_window.scale.y = 0.5

func window_move():
	if moving:
		character_window.position = character_window_start - (moving_start - get_global_mouse_position())

func is_hovering():
	return hovering

func _on_title_plate_button_down():
	moving = true
	moving_start = get_global_mouse_position()
	character_window_start = character_window.position
	
func _on_title_plate_button_up():
	moving = false

func _on_panel_container_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)
	
func _on_panel_container_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)

func _on_title_plate_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)

func _on_title_plate_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)

func _on_inventory_region_mouse_entered():
	inventory_hover = true
	
func _on_inventory_region_mouse_exited():
	inventory_hover = false

func _on_exit_window_pressed():
	toggle_menu()

func _on_resize_window_button_down():
	resizing = true

func _on_resize_window_button_up():
	resizing = false

func _on_exit_window_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)

func _on_exit_window_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)

func _on_resize_window_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)
	
func _on_resize_window_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)
