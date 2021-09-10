tool
extends Node
class_name FeatureEffect

# references ------------------------------------------------------------------
onready var parent = get_parent()

# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
var mouse_present = false setget set_mouse_present


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	if parent.has_signal("mouse_entered"):
		parent.connect("mouse_entered", self, "_on_mouse_entered")
	if parent.has_signal("mouse_exited"):
		parent.connect("mouse_exited", self, "_on_mouse_exited")
	
	
	# initialize setgets
	self.mouse_present = mouse_present


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_mouse_present(new_val):
	mouse_present = new_val


# signal functions ------------------------------------------------------------
func _on_mouse_entered():
	self.mouse_present = true


func _on_mouse_exited():
	self.mouse_present = false
