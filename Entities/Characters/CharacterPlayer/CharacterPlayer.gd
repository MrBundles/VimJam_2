extends KinematicBody2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var speed = 0 setget set_speed, get_speed
var direction = Vector2.UP


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	# initialize setgets
	pass


func _process(delta):
	pass


func _physics_process(delta):
	# do not process if editor is in edit mode
	if GEM.editor_mode == GVM.EDITOR_MODES.edit:
		return
	
	move_and_slide(Vector2(0, 5), Vector2.UP)


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------
func set_speed(new_val):
	speed = new_val


func get_speed():
	return speed


# signal functions ------------------------------------------------------------


