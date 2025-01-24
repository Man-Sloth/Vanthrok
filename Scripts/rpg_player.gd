extends CharacterBody2D

@onready var body_sprite = $"Body Sprite"
@onready var chest_sprite = $"Chest Sprite"
@onready var leggings_sprite = $"Leggings Sprite"
@onready var helmet_sprite = $"Helm Sprite"
@onready var gauntlet_sprite = $"Gauntlet Sprite"
@onready var weapon_sprite = $"Weapon Sprite"
@onready var shield_sprite = $"Shield Sprite"

var new_animation

const MALE_NORMAL_MODE = preload("res://Assets/sprites/SpriteFrames/Male_Normal_Mode.tres")
const MALE_ATTACK_MODE = preload("res://Assets/sprites/SpriteFrames/Male_Attack_Mode.tres")

var speed = 70000
var idle = false
var attack_mode = false
var attack_released = true
enum dir {N, E, W, S, NE, SE, SW, NW}
var facing = dir.S
var currentFrame = 0
var currentAnimation = "idle_down"
enum armorslot {HELM, GAUNTLET, SHIELD, LEGGINGS, WEAPON, CHEST}
enum armor_mat {CLOTH} 
var shirt_type = -1
var helmet_type = armor_mat.CLOTH
var pants_type = armor_mat.CLOTH
var gloves_type = armor_mat.CLOTH
var weapon_type = armor_mat.CLOTH
var shield_type = armor_mat.CLOTH

var last_shirt_type = -1
var last_helmet_type = -1
var last_pants_type = -1
var last_gloves_type = -1
var last_weapon_type = -1
var last_shield_type = -1

var load_shirt = false
var load_thread = Thread.new()

var loaded_animations = []

func _ready():
	pass

func _process(_delta):
	#Server.FetchPlayerStats("Player Stats", get_instance_id())
	
	if shirt_type != last_shirt_type:
		if load_shirt == false:
			load_shirt = true
			#ResourceLoader.load_threaded_request("res://Assets/sprites/SpriteFrames/Human_Shirt.tres")
			#load_thread.start(load_resource)
		
	if Input.is_action_just_released("attack_mode"):
		attack_released = true
	
	if attack_released:
		if Input.is_action_pressed("attack_mode"):
			attack_released = false
			if attack_mode:
				attack_mode = false
			else:
				attack_mode = true

	if attack_mode:
		body_sprite.sprite_frames = MALE_ATTACK_MODE
	else:
		body_sprite.sprite_frames = MALE_NORMAL_MODE
	
func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	var dirNormed = Vector2(256*directionX, 128*directionY).normalized()
	directionX = dirNormed.x
	directionY = dirNormed.y
	
	if Input.is_action_pressed("move_to_mouse"):
		var direction = (get_global_mouse_position() - self.position).normalized()
		directionX = direction.x
		directionY = direction.y
		
	idle = false
	if directionX == 0 && directionY == 0:
		idle = true
	elif directionX > 0:
		if abs(abs(directionY) - directionX) < 0.5:
			if directionY > 0:
				facing = dir.SE
			else:
				facing = dir.NE
		elif directionX > abs(directionY):
			facing = dir.E	
		else:
			if directionY > 0:
				facing = dir.S
			else:
				facing = dir.N
	else:
		if abs(abs(directionY) - abs(directionX)) < 0.5:
			if directionY > 0:
				facing = dir.SW
			else:
				facing = dir.NW
		elif abs(directionX) > abs(directionY):
			facing = dir.W
		else:
			if directionY > 0:
				facing = dir.S
			else:
				facing = dir.N
	
	if idle:
		if facing == dir.S:
			chest_sprite.play("idle_south")
		elif facing == dir.N:
			chest_sprite.play("idle_north")
		elif facing == dir.W:
			chest_sprite.play("idle_west")
		elif facing == dir.E:
			chest_sprite.play("idle_east")
		elif facing == dir.NE:
			chest_sprite.play("idle_NE")
		elif facing == dir.SE:
			chest_sprite.play("idle_SE")
		elif facing == dir.SW:
			chest_sprite.play("idle_SW")
		elif facing == dir.NW:
			chest_sprite.play("idle_NW")
	else:
		if facing == dir.S:
			chest_sprite.play("walk_south")
		elif facing == dir.N:
			chest_sprite.play("walk_north")
		elif facing == dir.W:
			chest_sprite.play("walk_west")
		elif facing == dir.E:
			chest_sprite.play("walk_east")
		elif facing == dir.NE:
			chest_sprite.play("walk_NE")
		elif facing == dir.SE:
			chest_sprite.play("walk_SE")
		elif facing == dir.SW:
			chest_sprite.play("walk_SW")
		elif facing == dir.NW:
			chest_sprite.play("walk_NW")
	
	chest_sprite.frame = body_sprite.frame
			
	if idle:
		if facing == dir.S:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_south")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_south")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_south")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_south")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_south")	
			body_sprite.play("idle_down")
			
		elif facing == dir.N:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_north")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_north")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_north")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_north")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_north")	
			body_sprite.play("idle_up")
			
		elif facing == dir.W:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_west")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_west")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_west")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_west")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_west")	
			body_sprite.play("idle_left")
			
		elif facing == dir.E:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_east")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_east")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_east")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_east")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_east")	
			body_sprite.play("idle_right")
			
		elif facing == dir.NE:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_NE")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_NE")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_NE")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_NE")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_NE")	
			body_sprite.play("idle_NE")
			
		elif facing == dir.SE:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_SE")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_SE")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_SE")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_SE")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_SE")	
			body_sprite.play("idle_SE")
			
		elif facing == dir.SW:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_SW")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_SW")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_SW")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_SW")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_SW")	
			body_sprite.play("idle_SW")
			
		elif facing == dir.NW:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("idle_NW")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("idle_NW")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("idle_NW")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("idle_NW")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("idle_NW")	
			body_sprite.play("idle_NW")
			
		
	else: #walking
		currentFrame = body_sprite.get_frame()
		currentAnimation = body_sprite.get_animation()
		if facing == dir.S:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_south")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_south")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_south")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_south")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_south")		
			body_sprite.play("walk_down")
			
		elif facing == dir.N:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_north")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_north")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_north")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_north")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_north")	
			body_sprite.play("walk_up")
			
		elif facing == dir.W:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_west")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_west")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_west")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_west")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_west")	
			body_sprite.play("walk_left")
			
		elif facing == dir.E:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_east")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_east")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_east")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_east")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_east")	
			body_sprite.play("walk_right")
			
		elif facing == dir.NE:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_NE")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_NE")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_NE")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_NE")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_NE")	
			body_sprite.play("walk_NE")
			
		elif facing == dir.SE:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_SE")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_SE")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_SE")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_SE")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_SE")	
			body_sprite.play("walk_SE")
			
		elif facing == dir.SW:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_SW")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_SW")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_SW")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_SW")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_SW")	
			body_sprite.play("walk_SW")
			
		elif facing == dir.NW:
			if helmet_type == armor_mat.CLOTH:
				helmet_sprite.play("walk_NW")
			if pants_type == armor_mat.CLOTH:
				leggings_sprite.play("walk_NW")
			if gloves_type == armor_mat.CLOTH:
				gauntlet_sprite.play("walk_NW")
			if weapon_type == armor_mat.CLOTH:
				weapon_sprite.play("walk_NW")	
			if shield_type == armor_mat.CLOTH:
				shield_sprite.play("walk_NW")	
			body_sprite.play("walk_NW")
			
		if currentAnimation != body_sprite.get_animation():
			body_sprite.set_frame_and_progress(currentFrame, 0.0)
			chest_sprite.set_frame_and_progress(currentFrame, 0.0)
			helmet_sprite.set_frame_and_progress(currentFrame, 0.0)
			leggings_sprite.set_frame_and_progress(currentFrame, 0.0)
			gauntlet_sprite.set_frame_and_progress(currentFrame, 0.0)
			weapon_sprite.set_frame_and_progress(currentFrame, 0.0)
			shield_sprite.set_frame_and_progress(currentFrame, 0.0)
		
	# Apply movement
	if directionX:
		velocity.x = directionX * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if directionY:
		velocity.y = directionY * speed * delta
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	move_and_slide()


func set_chest_type(type):
	shirt_type = type

func start_load_thread(path, armor_type, item_type):
	load_thread.start(load_resource.bind([path, armor_type, item_type]))
	
func load_resource(path, armor_type, item_type):
	new_animation = load(path)
	
	
	
			
	#loaded_animations.add(new_animation)
	#if armor_type == armor_mat.CLOTH:
	#	if item_type == 1: #Chest piece
	#		call_deferred("set_chest_frames")

func set_frames(object):
	if object.get_item_type() == 1:
		chest_sprite.sprite_frames = object.get_frames().sprite_frames
		chest_sprite.visible = true
			
func add_animation(armor_type, item_type):
	var path
	if(armor_type == armor_mat.CLOTH):
		if item_type == 1: #Chest piece
			path = "res://Assets/sprites/SpriteFrames/Human_Shirt.tres"
	if path != null:
		start_load_thread(path, armor_type, item_type)
		
func remove_animation(asset_path):
	loaded_animations.erase(asset_path)
	
func clear_spriteframes():
	chest_sprite.sprite_frames = null
	shirt_type = -1

func Set_Speed(player_speed):
	speed = player_speed
