extends Camera2D

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------



# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	GSM.connect("set_editor_mode", self, "_on_set_editor_mode")
	
	
	# initialize
	current = true
	global_position = GEM.base_window_size / Vector2(2,2)


func _process(delta):
	pass


func _get_configuration_warning():
	if 0:
		return "Configuration Warning String"
	else:
		return ""


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------
func _on_set_editor_mode(new_editor_mode):
	if new_editor_mode != GVM.EDITOR_MODES.edit:
		current = true
		

