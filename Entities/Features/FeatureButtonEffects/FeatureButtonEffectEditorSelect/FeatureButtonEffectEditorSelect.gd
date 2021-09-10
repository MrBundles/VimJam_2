tool
extends FeatureButtonEffect

# references ------------------------------------------------------------------
onready var icon = button.get_node("Icon")
onready var background = button.get_node("Background")
onready var label = button.get_node("Label")


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var button_icon_color_normal = Color(1,1,1,1) setget set_button_icon_color_normal
export var button_icon_color_hover = Color(1,1,1,1)
export var button_icon_color_pressed = Color(1,1,1,1)
export var button_background_color_normal = Color(1,1,1,1) setget set_button_background_color_normal
export var button_background_color_hover = Color(1,1,1,1)
export var button_background_color_pressed = Color(1,1,1,1)
export var button_label_color_normal = Color(1,1,1,1) setget set_button_label_color_normal
export var button_label_color_hover = Color(1,1,1,1)
export var button_label_color_pressed = Color(1,1,1,1)
export var button_icon_scale_normal = 1.0 setget set_button_icon_scale_normal
export var button_icon_scale_hover = 1.0
export var button_icon_scale_pressed = 1.0


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	self.button_icon_color_normal = button_icon_color_normal
	self.button_background_color_normal = button_background_color_normal
	self.button_label_color_normal = button_label_color_normal
	self.button_icon_scale_normal = button_icon_scale_normal
	
	# initialize button background
	background.position = button.rect_size / Vector2(2,2)
	
	var background_sprite_size = background.texture.get_size()
	background.scale = button.rect_size / background_sprite_size


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
	
	if has_node("FeatureTween") and icon and label:
		$FeatureTween.stop_all()
		
		if mouse_present:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(background, "modulate", background.modulate, button_background_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "scale", icon.scale, Vector2(button_icon_scale_hover, button_icon_scale_hover), .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		else:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_normal, .75, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(background, "modulate", background.modulate, button_background_color_normal, .75, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "scale", icon.scale, Vector2(button_icon_scale_normal, button_icon_scale_normal), .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_normal, .75, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.0)
		
		$FeatureTween.start()


func set_mouse_pressed(new_val):
	mouse_pressed = new_val
	
	if has_node("FeatureTween") and icon and label:
		$FeatureTween.stop_all()
		
		if mouse_pressed:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_pressed, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(background, "modulate", background.modulate, button_background_color_pressed, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_pressed, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "scale", icon.scale, Vector2(button_icon_scale_pressed, button_icon_scale_pressed), .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		else:
			$FeatureTween.interpolate_property(icon, "modulate", icon.modulate, button_icon_color_hover, .75, Tween.TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(background, "modulate", background.modulate, button_background_color_hover, .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(label, "modulate", label.modulate, button_label_color_hover, .75,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
			$FeatureTween.interpolate_property(icon, "scale", icon.scale, Vector2(button_icon_scale_hover, button_icon_scale_hover), .75, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		
		$FeatureTween.start()


func set_button_icon_color_normal(new_val):
	button_icon_color_normal = new_val
	
	if icon:
		icon.modulate = button_icon_color_normal


func set_button_background_color_normal(new_val):
	button_background_color_normal = new_val
	
	if background:
		background.modulate = button_background_color_normal


func set_button_label_color_normal(new_val):
	button_label_color_normal = new_val
	
	if label:
		label.modulate = button_label_color_normal


func set_button_icon_scale_normal(new_val):
	button_icon_scale_normal = new_val
	
	if icon:
		icon.scale = Vector2(button_icon_scale_normal, button_icon_scale_normal)


# signal functions ------------------------------------------------------------


