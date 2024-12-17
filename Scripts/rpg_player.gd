extends CharacterBody2D

@onready var animated_sprite = $"Body Sprite"
@onready var cloth_shirt_sprite = $"Shirt/Cloth Shirt Sprite"
@onready var cloth_pants_sprite = $"Pants/Cloth Pants Sprite"
@onready var cloth_helmet_sprite = $"Hat/Cloth Helmet Sprite"
@onready var cloth_gloves_sprite = $"Gloves/Cloth Gloves Sprite"
@onready var level1_weapon_sprite = $"Weapon/Level1 Weapon Sprite"

@onready var shield_sprite = $"Shield Sprite"


const SPEED = 70000.0
var idle = true
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

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
			animated_sprite.play("idle_down")
			
			shield_sprite.play("idle_south")
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
			animated_sprite.play("idle_up")
			
			shield_sprite.play("idle_north")
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
			animated_sprite.play("idle_left")
			
			shield_sprite.play("idle_west")
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
			animated_sprite.play("idle_right")
			
			shield_sprite.play("idle_east")
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
			animated_sprite.play("idle_NE")
			
			shield_sprite.play("idle_NE")
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
			animated_sprite.play("idle_SE")
			
			shield_sprite.play("idle_SE")
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
			animated_sprite.play("idle_SW")
			
			shield_sprite.play("idle_SW")
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
				
			animated_sprite.play("idle_NW")
			
			shield_sprite.play("idle_NW")
		currentFrame = 0
	else:
		currentFrame = animated_sprite.get_frame()
		currentAnimation = animated_sprite.get_animation()
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
			animated_sprite.play("walk_down")
			
			shield_sprite.play("walk_south")
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
			animated_sprite.play("walk_up")
			
			shield_sprite.play("walk_north")
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
			animated_sprite.play("walk_left")
			
			shield_sprite.play("walk_west")
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
			animated_sprite.play("walk_right")
			
			shield_sprite.play("walk_east")
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
			animated_sprite.play("walk_NE")
			
			shield_sprite.play("walk_NE")
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
			animated_sprite.play("walk_SE")
			
			shield_sprite.play("walk_SE")
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
			animated_sprite.play("walk_SW")
			
			shield_sprite.play("walk_SW")
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
			animated_sprite.play("walk_NW")
			
			shield_sprite.play("walk_NW")
		if currentAnimation != animated_sprite.get_animation():
			animated_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_shirt_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_pants_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_helmet_sprite.set_frame_and_progress(currentFrame, 0.0)
			cloth_gloves_sprite.set_frame_and_progress(currentFrame, 0.0)
			level1_weapon_sprite.set_frame_and_progress(currentFrame, 0.0)
			shield_sprite.set_frame_and_progress(currentFrame, 0.0)
		
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
	

	
