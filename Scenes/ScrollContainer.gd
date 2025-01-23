extends ScrollContainer
@onready var scroll_up = $"../../Scroll Up"
@onready var scroll_down = $"../../Scroll Down"
@onready var game_manager = $"../../GameManger"




var top_being_pushed = false
var bottom_being_pushed = false
var speed = 3500
var scale_shrink = 0.4
var scale_default = 0.5
var mouse_regular = preload("res://Assets/sprites/UI/Mouse Cursor/MouseCursor.png")
var mouse_clicked = preload("res://Assets/sprites/UI/Mouse Cursor/MouseCursor2.png")
var hovering = false


func _ready():
	pass
				

func _on_scroll_up_button_down():
	#var current_scroll = self.get_v_scroll()
	#var scroll_amount = 250
	#var new_scroll = current_scroll - scroll_amount
	#self.set_v_scroll(new_scroll)
	top_being_pushed = true
	scroll_up.scale = Vector2(scale_shrink, scale_shrink)
	scroll_up.pivot_offset = scroll_up.size / 10
	Input.set_custom_mouse_cursor(mouse_clicked)
	
	

func _on_scroll_up_button_up():
	top_being_pushed = false
	scroll_up.scale = Vector2(scale_default, scale_default)
	scroll_up.pivot_offset = Vector2(0, 0)
	Input.set_custom_mouse_cursor(mouse_regular)
	
	
func _on_scroll_down_button_down():
	#var current_scroll = self.get_v_scroll()
	#var scroll_amount =  250
	#var new_scroll = current_scroll + scroll_amount
	#self.set_v_scroll(new_scroll)
	bottom_being_pushed = true
	scroll_down.scale = Vector2(scale_shrink, scale_shrink)
	scroll_down.pivot_offset = scroll_up.size / 10
	Input.set_custom_mouse_cursor(mouse_clicked)
	
	
func _on_scroll_down_button_up():
	bottom_being_pushed = false
	scroll_down.scale = Vector2(scale_default, scale_default)
	scroll_down.pivot_offset = Vector2(0, 0)
	Input.set_custom_mouse_cursor(mouse_regular)
	
func _process(delta):
	var scroll_amount = speed * delta
	if top_being_pushed:
		var current_scroll = self.get_v_scroll()
		#var scroll_amount = 250
		var new_scroll = current_scroll - scroll_amount
		self.set_v_scroll(new_scroll)
		top_being_pushed = true
	elif bottom_being_pushed:
		var current_scroll = self.get_v_scroll()
		#var scroll_amount =  250
		var new_scroll = current_scroll + scroll_amount
		self.set_v_scroll(new_scroll)
	if get_v_scroll() == 0:
		scroll_up.visible = false
	else:
		scroll_up.visible = true
	if get_v_scroll() == 3183:
		scroll_down.visible = false
	else:
		scroll_down.visible = true
	if scroll_up.visible == false:
		top_being_pushed = false
		scroll_up.pivot_offset = Vector2(0, 0)
		scroll_up.scale = Vector2(scale_default, scale_default)
		Input.set_custom_mouse_cursor(mouse_regular)
	if scroll_down.visible == false:
		bottom_being_pushed = false
		scroll_down.pivot_offset = Vector2(0, 0)
		scroll_down.scale = Vector2(scale_default, scale_default)
		Input.set_custom_mouse_cursor(mouse_regular)
		
	
	
	
	
	
	
	
	#print (get_v_scroll())


func _on_scroll_up_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)


func _on_scroll_up_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)

func _on_scroll_down_mouse_entered():
	hovering = true
	game_manager.set_hovering_window(true)

func _on_scroll_down_mouse_exited():
	hovering = false
	game_manager.set_hovering_window(false)
