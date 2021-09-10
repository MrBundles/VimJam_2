tool
extends FeatureButtonEffect

# references ------------------------------------------------------------------
onready var icon = button.get_node("Icon")
onready var label = button.get_node("Label")


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var button_icon_color_normal = Color(1,1,1,1) setget set_button_icon_color_normal
export var button_icon_color_hover = Color(1,1,1,1)
export var button_label_color_normal = Color(1,1,1,1) setget set_button_label_color_normal
export var button_label_color_hover = Color(1,1,1,1)
export var button_icon_rotation_normal = 0 setget set_button_icon_rotation_normal
export var button_icon_rotation_hover = 0


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	self.button_icon_color_normal = button_icon_color_normal
	self.button_label_color_normal = button_label_color_normal
	self.button_icon_rotation_normal = button_icon_rotation_normal


func _process(delta):
	pass


func _get_configuration_warning():
	if get_parent() and not get_parent() is Button:
		return "Feature can only be added to a Button Icon Node"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_mouse_present(new_val):
	mouse_present = new_val
	
	if has_node("FeatureTween") and icon:
		$FeatureTween.stop_all()
		
		if mouse_present:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "rotation_degrees", icon.rotation_degrees, button_icon_rotation_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		else:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_normal, .75,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_normal, .75,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "rotation_degrees", icon.rotation_degrees, button_icon_rotation_normal, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		
		$FeatureTween.start()


func set_mouse_pressed(new_val):
	mouse_pressed = new_val
	
	$FeatureTween.stop_all()
	
#	if mouse_pressed:
#		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_mouse_pressed, .5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
#	else:
#		$FeatureTween.interpolate_property(self, "pop_current", pop_current, pop_in, .25,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
	
	$FeatureTween.start()


func set_button_icon_color_normal(new_val):
	button_icon_color_normal = new_val
	
	if icon:
		icon.modulate = button_icon_color_normal


func set_button_label_color_normal(new_val):
	button_label_color_normal = new_val
	
	if label:
		label.modulate = button_label_color_normal


func set_button_icon_rotation_normal(new_val):
	button_icon_rotation_normal = new_val
	
	if icon:
		icon.rotation_degrees = button_icon_rotation_normal


# signal functions ------------------------------------------------------------


