extends ScrollContainer
@onready var scroll_up = $"../../Scroll Up"
@onready var scroll_down = $"../../Scroll Down"



var top_being_pushed = false
var bottom_being_pushed = false
var speed = 3500
	

func _on_scroll_up_button_down():
	
	#var current_scroll = self.get_v_scroll()
	#var scroll_amount = 250
	#var new_scroll = current_scroll - scroll_amount
	#self.set_v_scroll(new_scroll)
	top_being_pushed = true

func _on_scroll_up_button_up():
	top_being_pushed = false
	
	
func _on_scroll_down_button_down():
	#var current_scroll = self.get_v_scroll()
	#var scroll_amount =  250
	#var new_scroll = current_scroll + scroll_amount
	#self.set_v_scroll(new_scroll)
	bottom_being_pushed = true
	
func _on_scroll_down_button_up():
	bottom_being_pushed = false
	
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
	if scroll_down.visible == false:
		bottom_being_pushed = false
		
	
	
	
	
	
	
	
	#print (get_v_scroll())
	
