tool
extends Node

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var label = "Label" setget set_label
export(GVM.ALIGN) var label_align = GVM.ALIGN.left setget set_label_align
export var placeholder = "Placeholder" setget set_placeholder
export(GVM.ALIGN) var placeholder_align = GVM.ALIGN.left setget set_placeholder_align
export var font_size = 48 setget set_font_size
var value = ""


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("bug_report_sent", self, "_on_bug_report_sent")
	
	# initialize variables
	self.label = label
	self.label_align = label_align
	self.placeholder = placeholder
	self.placeholder_align = placeholder_align
	self.font_size = font_size


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_label(new_val):
	label = new_val
	
	$Label.text = label


func set_label_align(new_val):
	label_align = new_val
	$Label.align = label_align


func set_placeholder(new_val):
	placeholder = new_val
	
	$LineEdit.placeholder_text = placeholder


func set_placeholder_align(new_val):
	placeholder_align = new_val
	$LineEdit.align = placeholder_align


func set_font_size(new_val):
	font_size = new_val
	
	$Label/FeatureFontSizeOverrider.font_size = font_size
	$LineEdit/FeatureFontSizeOverrider.font_size = font_size


# signal functions ------------------------------------------------------------
func _on_LineEdit_text_changed(new_text):
	value = new_text


func _on_bug_report_sent():
	$LineEdit.text = ""
