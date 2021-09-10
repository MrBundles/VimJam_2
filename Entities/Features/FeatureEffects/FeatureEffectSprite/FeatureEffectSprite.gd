tool
extends FeatureEffect

# references ------------------------------------------------------------------
onready var sprite : Sprite = parent.get_node("Sprite")

# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
var selected = false setget set_selected

export var highlight_color_normal = Color(1,1,1,1)
export var highlight_color_hover = Color(1,1,1,1)
export var highlight_color_selected = Color(1,1,1,1)
var highlight_color_current = highlight_color_normal setget set_highlight_color_current
export var highlight_width_normal = 0
export var highlight_width_hover = 5
export var highlight_width_selected = 5


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("set_editor_pointer_mode", self, "_on_set_editor_pointer_mode")
	
	# initialize editor pointer mode
	_on_set_editor_pointer_mode(GEM.editor_pointer_mode)
	
	# initialize setgets
	self.highlight_color_current = highlight_color_current


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_selected(new_val):
	selected = new_val


func set_mouse_present(new_val):
	mouse_present = new_val
	
	# if item is selected, disregard mouse hover animations
	if has_node("FeatureTween") and sprite and not selected:
		$FeatureTween.stop_all()
		
		if mouse_present:
			$FeatureTween.interpolate_property(sprite.material, "shader_param/width", sprite.material.get_shader_param("width"), highlight_width_hover, .15, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.0)
		else:
			$FeatureTween.interpolate_property(sprite.material, "shader_param/width", sprite.material.get_shader_param("width"), highlight_width_normal, .15,Tween. TRANS_QUINT, Tween.EASE_OUT, 0.0)
		
		$FeatureTween.start()


func set_highlight_color_current(new_val):
	highlight_color_current = new_val
	
	if sprite:
		sprite.material.set_shader_param("color", highlight_color_current)


# signal functions ------------------------------------------------------------
func _on_set_editor_pointer_mode(new_editor_pointer_mode):
	match new_editor_pointer_mode:
		GVM.EDITOR_POINTER_MODES.select:
			self.highlight_color_current = highlight_color_normal
		GVM.EDITOR_POINTER_MODES.move:
			self.highlight_color_current = highlight_color_normal
		GVM.EDITOR_POINTER_MODES.rotate:
			self.highlight_color_current = highlight_color_normal
