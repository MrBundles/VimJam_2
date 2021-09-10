tool
extends FeatureButtonEffect

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var pop_default = -8
export var pop_mouse_present = 32
export var pop_mouse_pressed = 48
var pop_current = pop_default setget set_pop_current
export var pop_color = Color(1,1,1,1) setget set_pop_color


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize variables
	self.pop_current = pop_default
	self.pop_color = pop_color
	
	# set border position
	$PopSprite.position = button.rect_size / Vector2(2,2)


func _process(delta):
	pass


func _get_configuration_warning():
	if get_parent() and not get_parent() is Button:
		return "Feature can only be added to a Button Node"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_mouse_present(new_val):
	mouse_present = new_val
	
	$FeatureTween.stop_all()
	
	if mouse_present:
		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_mouse_present, .5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
	else:
		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_default, .25,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
	
	$FeatureTween.start()


func set_mouse_pressed(new_val):
	mouse_pressed = new_val
	
	$FeatureTween.stop_all()
	
	if mouse_pressed:
		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_mouse_pressed, .5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
	else:
		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_default, .25,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
	
	$FeatureTween.start()


func set_pop_current(new_val):
	pop_current = new_val
	
	var pop_sprite_size = $PopSprite.texture.get_size()
	
	if has_node("PopSprite"):
		# set border size
		$PopSprite.scale = (button.rect_size + Vector2(pop_current, pop_current)) / pop_sprite_size


func set_pop_color(new_val):
	pop_color = new_val
	
	if has_node("PopSprite"):
		$PopSprite.modulate = pop_color


# signal functions ------------------------------------------------------------
