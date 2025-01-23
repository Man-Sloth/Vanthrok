extends TextureRect

@onready var game_manager = $"../../../../../../GameManager"
@onready var item_sprite = $item_sprite
@onready var player = $"../../../../../../RPG_Player"

@export_group("Item Properties")
enum ITEM_TYPE {Helm, Chest, Legs, Arms, Weapon, Shield, Stackable, Non_Stackable, Empty = -1}
@export var Item_Type: ITEM_TYPE
const OBJECTSCENE = preload("res://Scenes/object.tscn")
var holdOffset = Vector2(115,170)
enum armor_mat {CLOTH} 
var hovering = false
var object = null
var slot_object = null
var loaded_animation = AnimatedSprite2D.new()
var dummy_image = Sprite2D.new()
var load_thread = Thread.new()
#var new_animation = load("res://Assets/sprites/SpriteFrames/Human_BLANK.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	animate()
	
func _input(event):
	if hovering && game_manager.get_held_object() != null: #drop item into slot
		if event.is_action_released("pickup"):
			
			object = game_manager.get_held_object()
			if slot_object == null:
				slot_object = OBJECTSCENE.instantiate()
				slot_object.visible = false
				slot_object.set_item_type(object.get_item_type())
				slot_object.set_armor_type(object.get_armor_type())
				Item_Type = slot_object.get_item_type()
				slot_object.set_resource_path(object.get_resource_path())
				add_child(slot_object)
				
				
				#slot_object.get_node("AnimatedSprite2D").set_sprite_frames(object.get_node("AnimatedSprite2D").get_sprite_frames())
				#slot_object.set_frames(slot_object.load_animations())
				#player.add_animation(object.get_armor_type(), object.get_item_type())
				add_animation(slot_object)
				
				object.delete()
				game_manager.set_texture(null)
				game_manager.set_held_object(null)
				game_manager.set_pulled_location(null)
				game_manager.set_pulled_char_location(null)
			else:
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

func add_animation(object):
	var path = object.get_resource_path()
	var dummy_path = object.get_dummy_path()
	var armor_type = object.get_armor_type()
	var item_type = object.get_item_type()
	start_load_thread(path, dummy_path)

func start_load_thread(path, dummy_path):
	load_thread.start(load_resource.bind(path, dummy_path))
		
func load_resource(path, dummy_path):
	var new_animation = AnimatedSprite2D.new()
	var new_dummy_image = Sprite2D.new()
	new_animation.sprite_frames = load(path)
	new_dummy_image.texture = load(dummy_path)
	call_deferred("set_animation_frames", new_animation, new_dummy_image)
	
func set_animation_frames(new_animation, new_dummy_image):
	load_thread.wait_to_finish()
	loaded_animation.sprite_frames = new_animation.sprite_frames
	dummy_image.texture = new_dummy_image.texture
	slot_object.set_frames(loaded_animation)
	slot_object.set_dummy(dummy_image)
	

func _on_mouse_entered():
	game_manager.set_hovering_slot(true)
	hovering = true
	print("hovering")

func _on_mouse_exited():
	game_manager.set_hovering_slot(false)
	hovering = false
	print("not hovering")
	
func set_slot_object(new_object):
	slot_object = new_object
	
func get_slot_object():
	return slot_object
	
func get_item_type():
	return Item_Type
	
func set_item_type(type):
	Item_Type = type
