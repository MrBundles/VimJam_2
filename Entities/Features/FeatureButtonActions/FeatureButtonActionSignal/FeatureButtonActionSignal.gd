tool
extends FeatureButtonAction

# references ------------------------------------------------------------------


# signals ---------------------------------------------------------------------


# variables -------------------------------------------------------------------
export var signal_name = ""
export(Array) var parameters


# main functions --------------------------------------------------------------
func _ready():
	# connect signals
	
	
	pass


func _process(delta):
	pass


# helper functions ------------------------------------------------------------



# set/get functions -----------------------------------------------------------



# signal functions ------------------------------------------------------------
func _on_button_pressed():
	# i couldn't think of a better way to do this... if you have one please let me know
	match parameters.size():
		0:
			GSM.emit_signal(signal_name)
		1:
			GSM.emit_signal(signal_name, parameters[0])
		2:
			GSM.emit_signal(signal_name, parameters[0], parameters[1])
		3:
			GSM.emit_signal(signal_name, parameters[0], parameters[1], parameters[2])
		4:
			GSM.emit_signal(signal_name, parameters[0], parameters[1], parameters[2], parameters[3])
		5:
			GSM.emit_signal(signal_name, parameters[0], parameters[1], parameters[2], parameters[3], parameters[4])
	
	if parameters.size() > 5:
		push_warning("warning: max of 5 parameters per signal")
