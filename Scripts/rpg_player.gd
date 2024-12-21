extends CharacterBody2D

@onready var body_sprite = $"Body Sprite"
@onready var cloth_shirt_sprite = $"Shirt/Cloth Shirt Sprite"
@onready var cloth_pants_sprite = $"Pants/Cloth Pants Sprite"
@onready var cloth_helmet_sprite = $"Hat/Cloth Helmet Sprite"
@onready var cloth_gloves_sprite = $"Gloves/Cloth Gloves Sprite"
@onready var level1_weapon_sprite = $"Weapon/Level1 Weapon Sprite"
@onready var level1_shield_sprite = $"Shield/Level1 Shield Sprite"

const MALE_NORMAL_MODE = preload("res://Assets/sprites/SpriteFrames/Male_Normal_Mode.tres")
const MALE_ATTACK_MODE = preload("res://Assets/sprites/SpriteFrames/Male_Attack_Mode.tres")

const SPEED = 70000.0
var idle = false
var attack_mode = false
enum dir {N, E, W, S, NE, SE, SW, NW}
var facing = dir.S
var currentFrame = 0
var currentAnimation = "idle_down"
enum armorslot {HELM, GAUNTLET, SHIELD, LEGGINGS, WEAPON, CHEST}
enum armor_mat {CLOTH} 
var shirt_type = armor_mat.CLOTH
var helmet_type = armor_mat.CLOTH
var pants_type = armor_mat.CLOTH
var gloves_type = armor_mat.CLOTH
var weapon_type = armor_mat.CLOTH
var shield_type = armor_mat.CLOTH
var attack_released = true
var loaded_animations = []
func _physics_process(delta):
	
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
			if shirt_type == armor_mat.CLOTH:
				cloth_shirt_sprite.play("idle_south")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_south")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_south")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_south")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_south")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_south")	
			body_sprite.play("idle_down")
			
		elif facing == dir.N:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_north")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_north")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_north")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_north")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_north")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_north")	
			body_sprite.play("idle_up")
			
		elif facing == dir.W:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_west")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_west")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_west")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_west")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_west")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_west")	
			body_sprite.play("idle_left")
			
		elif facing == dir.E:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_east")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_east")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_east")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_east")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_east")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_east")	
			body_sprite.play("idle_right")
			
		elif facing == dir.NE:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_NE")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_NE")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_NE")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_NE")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_NE")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_NE")	
			body_sprite.play("idle_NE")
			
		elif facing == dir.SE:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_SE")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_SE")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_SE")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_SE")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_SE")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_SE")	
			body_sprite.play("idle_SE")
			
		elif facing == dir.SW:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_SW")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_SW")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_SW")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_SW")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_SW")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_SW")	
			body_sprite.play("idle_SW")
			
		elif facing == dir.NW:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("idle_NW")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("idle_NW")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("idle_NW")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("idle_NW")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("idle_NW")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("idle_NW")	
			body_sprite.play("idle_NW")
			
		currentFrame = 0
	else:
		currentFrame = body_sprite.get_frame()
		currentAnimation = body_sprite.get_animation()
		if facing == dir.S:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_south")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_south")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_south")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_south")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_south")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_south")		
			body_sprite.play("walk_down")
			
		elif facing == dir.N:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_north")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_north")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_north")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_north")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_north")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_north")	
			body_sprite.play("walk_up")
			
		elif facing == dir.W:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_west")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_west")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_west")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_west")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_west")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_west")	
			body_sprite.play("walk_left")
			
		elif facing == dir.E:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_east")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_east")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_east")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_east")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_east")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_east")	
			body_sprite.play("walk_right")
			
		elif facing == dir.NE:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_NE")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_NE")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_NE")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_NE")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_NE")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_NE")	
			body_sprite.play("walk_NE")
			
		elif facing == dir.SE:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_SE")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_SE")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_SE")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_SE")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_SE")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_SE")	
			body_sprite.play("walk_SE")
			
		elif facing == dir.SW:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_SW")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_SW")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_SW")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_SW")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_SW")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_SW")	
			body_sprite.play("walk_SW")
			
		elif facing == dir.NW:
			if(shirt_type == armor_mat.CLOTH):
				cloth_shirt_sprite.play("walk_NW")
			if helmet_type == armor_mat.CLOTH:
				cloth_helmet_sprite.play("walk_NW")
			if pants_type == armor_mat.CLOTH:
				cloth_pants_sprite.play("walk_NW")
			if gloves_type == armor_mat.CLOTH:
				cloth_gloves_sprite.play("walk_NW")
			if weapon_type == armor_mat.CLOTH:
				level1_weapon_sprite.play("walk_NW")	
			if shield_type == armor_mat.CLOTH:
				level1_shield_sprite.play("walk_NW")	
			body_sprite.play("walk_NW")
			
		if currentAnimation != body_sprite.get_animation():
			body_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_shirt_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_pants_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_helmet_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_gloves_sprite.set_frame_and_progress(currentFrame, 0.0)
			level1_weapon_sprite.set_frame_and_progress(currentFrame, 0.0)
			level1_shield_sprite.set_frame_and_progress(currentFrame, 0.0)
		
	# Apply movement
	if directionX:
		velocity.x = directionX * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if directionY:
		velocity.y = directionY * SPEED * delta
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()
	

func load_resources(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			# do something with the file
			var animation = load(file_name)
			loaded_animations.append(animation)
			file_name = dir.get_next()
		return loaded_animations
	
