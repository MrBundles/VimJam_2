tool
extends Node
class_name FeatureButtonAction

# references ------------------------------------------------------------------
onready var button : Button = get_parent()


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------



# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	button.connect("pressed", self, "_on_button_pressed")
	
	# initialize setgets
	pass


func _process(delta):
	pass


func _get_configuration_warning():
	if get_parent() and not get_parent() is Button:
		return "Feature can only be added to a Button Node"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------


