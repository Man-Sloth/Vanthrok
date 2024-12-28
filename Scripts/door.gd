extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var door_sound = $DoorSound
@onready var door_sound_2 = $DoorSound2


func _on_body_entered(_body):
	animated_sprite_2d.visible = false
	door_sound.play()

func _on_body_exited(_body):
	animated_sprite_2d.visible = true
	door_sound_2.play()
