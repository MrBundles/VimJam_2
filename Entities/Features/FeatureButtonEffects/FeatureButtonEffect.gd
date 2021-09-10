tool
extends Node
class_name FeatureButtonEffect

# references ------------------------------------------------------------------
onready var button : Button = get_parent()

# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
var mouse_present = false setget set_mouse_present
var mouse_pressed = false setget set_mouse_pressed


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	button.connect("mouse_entered", self, "_on_mouse_entered")
	button.connect("mouse_exited", self, "_on_mouse_exited")
	button.connect("button_down", self, "_on_button_down")
	button.connect("button_up", self, "_on_button_up")
	
	# initialize setgets
	self.mouse_present = mouse_present
	self.mouse_pressed = mouse_pressed


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_mouse_present(new_val):
	mouse_present = new_val


func set_mouse_pressed(new_val):
	mouse_pressed = new_val


# signal functions ------------------------------------------------------------
func _on_mouse_entered():
	self.mouse_present = true


func _on_mouse_exited():
	self.mouse_present = false


func _on_button_down():
	self.mouse_pressed = true


func _on_button_up():
	self.mouse_pressed = false

