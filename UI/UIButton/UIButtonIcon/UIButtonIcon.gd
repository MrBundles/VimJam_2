tool
extends Button
class_name ButtonIcon

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export(Texture) var button_icon setget set_button_icon
var icon_size = Vector2(0,0) setget set_icon_size
export(String) var button_label setget set_button_label
export(GVM.DIRECTION) var label_position setget set_label_position
export var label_font_size = 24 setget set_label_font_size
export var label_offset = 16 setget set_label_offset


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize variables
	self.button_icon = button_icon
	self.icon_size = icon_size
	self.button_label = button_label
	self.label_position = label_position
	self.label_font_size = label_font_size


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_button_icon(new_val):
	button_icon = new_val
	
	if has_node("Icon"):
		$Icon.texture = button_icon
		self.icon_size = button_icon.get_size()
		$Icon.position = icon_size / 2


func set_icon_size(new_val):
	icon_size = new_val
	
	rect_min_size = icon_size


func set_button_label(new_val):
	button_label = new_val
	
	if has_node("Label"):
		$Label.text = button_label


func set_label_position(new_val):
	label_position = new_val
	
	if has_node("Label"):
		match label_position:
			GVM.DIRECTION.up:
				$Label.rect_position = Vector2(icon_size.x / 2.0 - $Label.rect_size.x / 2.0, -label_offset - $Label.rect_size.y)
				$Label.align = Label.ALIGN_CENTER
			GVM.DIRECTION.down:
				$Label.rect_position = Vector2(icon_size.x / 2.0 - $Label.rect_size.x / 2.0, label_offset + $Label.rect_size.y + icon_size.y / 2)
				$Label.align = Label.ALIGN_CENTER
			GVM.DIRECTION.left:
				$Label.rect_position = Vector2(-label_offset - $Label.rect_size.x, $Label.rect_size.y / 2.0)
				$Label.align = Label.ALIGN_RIGHT
			GVM.DIRECTION.right:
				$Label.rect_position = Vector2(label_offset + icon_size.x, $Label.rect_size.y / 2.0)
				$Label.align = Label.ALIGN_LEFT


func set_label_font_size(new_val):
	label_font_size = new_val
	
	if has_node("Label/FeatureFontSizeOverrider"):
		$Label/FeatureFontSizeOverrider.font_size = label_font_size


func set_label_offset(new_val):
	label_offset = new_val
	
	# update label position to reflect new offset value
	self.label_position = label_position


# signal functions ------------------------------------------------------------

